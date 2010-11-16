module Iom
  module Data

    DEFAULT_MEDIA_RESOURCE = :food_picture

    def attributes_for_media_resource(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_MEDIA_RESOURCE
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :food_picture
          {
            :element => create_project(DEFAULT_PROJECT),
            :picture => File.open("#{Rails.root}/test/support/images/caritas.jpg", "rb")
          }
        when :food_video
          {
            :element => create_project(DEFAULT_PROJECT),
            :vimeo_url => "http://vimeo.com/11144228"
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_media_resource(attributes_or_fixture = {})
      MediaResource.new(attributes_for_media_resource(attributes_or_fixture))
    end

    def create_media_resource(attributes_or_fixture = {})
      r = new_media_resource(attributes_or_fixture)
      r.save
      r.reload
    end

  end
end