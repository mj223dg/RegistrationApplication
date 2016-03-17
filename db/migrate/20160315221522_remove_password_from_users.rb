class RemovePasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password, :string
    remove_column :users, :confirmpassword, :string
  end
end