class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password, :string
    add_column :users, :password_digest, :encrypted_password
  end
end
