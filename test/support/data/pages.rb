module Iom
  module Data

    DEFAULT_PAGE = :faq

    def attributes_for_page(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_PAGE
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :faq
          {
            :title => 'FAQ',
            :body => "<p>This is the first paragraph</p><p>This is the second paragraph</p>",
            :site_id => create_site.id
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_page(attributes_or_fixture = {})
      Page.new(attributes_for_page(attributes_or_fixture))
    end

    def create_page(attributes_or_fixture = {})
      p = new_page(attributes_or_fixture)
      p.save
      p.reload
    end

  end
end