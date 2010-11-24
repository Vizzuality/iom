class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :default_email
      t.string :default_contact_name
      t.string :geoiq_parameter_1
      t.string :geoiq_parameter_2
    end
  end

  def self.down
    drop_table :settings
  end
end
