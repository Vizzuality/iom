class ChnagePropertiesLength < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.change :implementing_organization, :text
      t.change :partner_organizations, :text
      t.change :cross_cutting_issues, :text
      t.change :target, :text
    end    
  end

  def self.down
  end
end
