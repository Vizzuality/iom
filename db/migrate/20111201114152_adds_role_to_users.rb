class AddsRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string

    # there is no users yet
    # admin = User.find(1)
    # admin.role = 'admin'
    # admin.save!

  end

  def self.down
    remove_column :users, :role
  end
end
