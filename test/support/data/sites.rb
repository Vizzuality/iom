module Iom
  module Data

    DEFAULT_SITE = :haiti_aid_map

    def attributes_for_site(attributes_or_fixture = {})
      if attributes_or_fixture.is_a?(Hash)
        attributes = attributes_or_fixture
        fixture = DEFAULT_SITE
      else
        attributes = {}
        fixture = attributes_or_fixture
      end

      # TODO:
      #  - add theme
      #  - add logo
      #  - project_classification
      default_attributes = case fixture
        # Global project, associated to a cluster
        when :haiti_aid_map
          cluster = create_cluster :name => 'food'
          {
            :name => 'Haiti Aid Map', :short_description => 'Haiti Aid Map short desc',
            :long_description => 'Haiti Aid Map long desc',
            :contact_email => 'contact@example.com', :contact_person => 'Haiti Contact Person',
            :url => 'http://haiti.aidmap.com', :google_analytics_id => 'GA-1234-321',
            :blog_url => '', :word_for_clusters => 'clisters', :word_for_regions => 'rigions',
            :show_global_donations_raises => true, :geographic_context_country_id => nil, :geographic_context_region_id => nil,
            :project_context_cluster_id => cluster.id
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