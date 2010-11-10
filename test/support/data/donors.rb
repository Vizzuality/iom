module Iom
  module Data

    DEFAULT_DONOR = :blat

    def attributes_for_donor(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_DONOR
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :blat
          {
            :name => "Fernando Blat",
            :description => "Fernando Blat has decide to be a donor in this project.",
            :website => "http://www.blatsoft.org/donors",
            :twitter => "blatsoft",
            :facebook => "www.facebook.com/blatsfot",
            :contact_person_name => "Fernando Blat",
            :contact_company => "Blatsoft",
            :contact_person_position => "BlatSoft CTO",
            :contact_email => "blat@example.com",
            :contact_phone_number => "+31 2321 2133",
            :site_specific_information => nil
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_donor(attributes_or_fixture = {})
      Donor.new(attributes_for_donor(attributes_or_fixture))
    end

    def create_donor(attributes_or_fixture = {})
      o = new_donor(attributes_or_fixture)
      o.save
      o.reload
    end

  end
end