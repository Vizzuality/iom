class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string      :name
      t.text        :description
      t.integer     :primary_organization
      t.string      :implementing_organization
      t.string      :partner_organization
      t.string      :cross_cutting_issues
      t.date        :start_date
      t.date        :end_date
      t.integer     :budget
      t.integer     :region_id
      t.string      :target
      t.integer     :people_reached
      t.string      :contact_person
      t.string      :contact_email
      t.string      :contact_phone
      t.geometry    :the_geom
      t.text        :site_specific_information
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
