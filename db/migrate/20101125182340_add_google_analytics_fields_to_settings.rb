class AddGoogleAnalyticsFieldsToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :google_analytics_username, :string
    add_column :settings, :google_analytics_password, :string
  end

  def self.down
    remove_column :settings, :google_analytics_username
    remove_column :settings, :google_analytics_password
  end
end
