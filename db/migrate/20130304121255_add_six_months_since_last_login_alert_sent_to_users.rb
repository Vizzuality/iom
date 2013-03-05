class AddSixMonthsSinceLastLoginAlertSentToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :six_months_since_last_login_alert_sent, :boolean, :default => false
  end

  def self.down
    add_column :users, :six_months_since_last_login_alert_sent
  end
end
