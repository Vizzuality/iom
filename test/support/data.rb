module Iom
  module Data

    DEFAULT_SITE = :food_security

    def attributes_for_site(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_SITE
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :food_security
          {
            :name => 'Food Security', :short_description => 'Food Security Short Desc',
            :long_description => 'Food Security Long Desc',
            :contact_email => 'contact@example.com', :contact_person => 'Food Security Contact Person',
            :url => 'http://food.security.com', :has_blog => false
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_site(attributes_or_fixture = {})
      Site.new(attributes_for_site(attributes_or_fixture))
    end

    def create_site(attributes_or_fixture = {})
      s = new_site(attributes_or_fixture)
      s.save
      s.reload
    end

  end
end