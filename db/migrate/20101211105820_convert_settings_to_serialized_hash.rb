class ConvertSettingsToSerializedHash < ActiveRecord::Migration
  def self.up
    drop_table :settings
    create_table :settings do |t|
      t.text   :data
    end
    s = Settings.new
    s.data ||= {}
    s.data[:default_email] = ""
    s.data[:default_contact_name] = ""
    s.data[:geoiq_parameter_1] = ""
    s.data[:geoiq_parameter_2] = ""
    s.save
  end

  def self.down
    drop_table :settings
    create_table :settings do |t|
      t.string :default_email
      t.string :default_contact_name
      t.string :geoiq_parameter_1
      t.string :geoiq_parameter_2
    end
  end
end
