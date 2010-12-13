module Iom
  module Data

    DEFAULT_SETTING = :haiti_aid_map

    def attributes_for_setting(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_SETTING
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :haiti_aid_map
          {
            :data => {
              :default_email             => 'admin@example.com',
              :default_contact_name      => 'Admin',
              :geoiq_parameter_1         => '',
              :geoiq_parameter_2         => '',
              :google_analytics_username => '',
              :google_analytics_password => ''
            }
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_setting(attributes_or_fixture = {})
      Settings.new(attributes_for_setting(attributes_or_fixture))
    end

    def create_setting(attributes_or_fixture = {})
      s = new_setting(attributes_or_fixture)
      s.save
      s.reload
    end

  end
end