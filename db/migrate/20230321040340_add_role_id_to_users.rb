class AddRoleIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role_id, :string
  end
end
