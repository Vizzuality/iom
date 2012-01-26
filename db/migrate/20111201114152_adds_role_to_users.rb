class AddsRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string

    admin = User.find(1)
    admin.role = 'admin'
    admin.save!
  end

  def self.down
    remove_column :users, :role
  end
end
