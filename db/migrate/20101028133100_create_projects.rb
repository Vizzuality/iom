class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string      :name
      t.text        :description
      t.integer     :primary_organization_id
      t.string      :implementing_organization
      t.string      :partner_organizations
      t.string      :cross_cutting_issues
      t.geometry    :the_geom, :srid => 4326, :null => false
      t.date        :start_date
      t.date        :end_date
      t.integer     :budget
      t.string      :target
      t.integer     :estimated_people_reached
      t.string      :contact_person
      t.string      :contact_email
      t.string      :contact_phone_number
      t.text        :site_specific_information
      t.timestamps
    end
    add_index :projects, :name
    add_index :projects, :primary_organization_id
    add_index :projects, :the_geom, :spatial=>true
  end

  def self.down
    drop_table :projects
  end
end
