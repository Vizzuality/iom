class AddPasswordResetFields < ActiveRecord::Migration
  def self.up
    add_column :users, :password_reset_token, :string
  end

  def self.down
  end
end
