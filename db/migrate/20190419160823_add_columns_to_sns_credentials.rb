class AddColumnsToSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :sns_credentials, :host_id, :string
  end
end
