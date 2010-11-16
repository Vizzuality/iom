module Iom
  module Data

    DEFAULT_RESOURCE = :food_security_pdf

    def attributes_for_resource(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_RESOURCE
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :food_security_pdf
          {
            :title => 'Food Security Report',
            :url => 'http://foodsecurity.org/report.pdf',
            :element => create_project(DEFAULT_PROJECT)
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_resource(attributes_or_fixture = {})
      Resource.new(attributes_for_resource(attributes_or_fixture))
    end

    def create_resource(attributes_or_fixture = {})
      r = new_resource(attributes_or_fixture)
      r.save
      r.reload
    end

  end
end