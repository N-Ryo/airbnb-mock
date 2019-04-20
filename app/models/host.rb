class Host < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      host = Host.where(id: snscredential.host_id).first
    else
      host = Host.where(email: auth.info.email).first
      if !host.present?
        host = Host.create(
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
          )
      end
      SnsCredential.create(
        uid: uid,
        provider: provider,
        host_id: host.id
        )
    end
    return host
  end
end
