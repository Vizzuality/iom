module Iom
  module Data

    DEFAULT_ORGANIZATION = :intermon

    def attributes_for_organization(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_ORGANIZATION
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      default_attributes = case fixture
        when :intermon
          {
            :name => "Intermon Oxfam",
            :description => "Oxfam America is an international relief and development organization that creates lasting solutions to poverty, hunger, and injustice. Together with individuals and local groups in more than 90 countries, Oxfam saves lives, helps people overcome poverty, and fights for social justice. We are one of the 14 affiliates in the international confederation, Oxfam.",
            :budget => 250000000,
            :website => "http://www.oxfamamerica.org",
            :staff => 1432,
            :twitter => "oxfamamerica",
            :facebook => "www.facebook.com/oxfamamerica",
            :hq_address => "Oxfam St, 32, City Center",
            :contact_email => "contact_intermon_oxfam@example.com",
            :contact_phone_number => "+31 2321 2133",
            :donation_address => "Donation Address Intermon Oxfam, 232, City Center",
            :zip_code => "UA23",
            :city => "New York",
            :state => "New York",
            :donation_phone_number => "+32 231 11 11 11",
            :donation_website => "http://www.oxfamamerica.org/donations",
            :site_specific_information => nil,
            :international_staff => "international staff",
            :contact_name => "Steve Balmer",
            :contact_position => "Intermon contact CEO",
            :contact_zip => "123",
            :contact_city => "Atlanta",
            :contact_state => "Maryland",
            :contact_country => "United States",
            :donation_country => "United States"
          }
        when :caritas
          {
            :name => "Caritas org",
            :description => "Description for caritas",
            :budget => 10000,
            :website => "http://www.caritas.es/",
            :staff => 500,
            :twitter => "caritas",
            :facebook => "www.facebook.com/caritas",
            :hq_address => "Caritas St, 32, City Center",
            :contact_email => "contact_caritas@example.com",
            :contact_phone_number => "+31 123 2133",
            :donation_address => "Donation Address Caritas, 232, City Center",
            :zip_code => "AB123",
            :city => "Madrid",
            :state => "Madrid",
            :donation_phone_number => "+32 231 11 11 11",
            :donation_website => "http://www.caritas.es/donations",
            :site_specific_information => nil,
            :international_staff => "international staff",
            :contact_name => "Steve Caritas",
            :contact_position => "Caritas contact CEO",
            :contact_zip => "28005",
            :contact_city => "Madrid",
            :contact_state => "Madrid",
            :contact_country => "Spain",
            :donation_country => "Spain"
          }
        else
          raise "Invalid fixture name"
      end
      default_attributes.merge(attributes)
    end

    def new_organization(attributes_or_fixture = {})
      Organization.new(attributes_for_organization(attributes_or_fixture))
    end

    def create_organization(attributes_or_fixture = {})
      o = new_organization(attributes_or_fixture)
      o.save
      o.reload
    end

  end
end