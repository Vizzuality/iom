# == Schema Information
#
# Table name: sites
#
#  id                              :integer         not null, primary key
#  name                            :string(255)     
#  short_description               :text            
#  long_description                :text            
#  contact_email                   :string(255)     
#  contact_person                  :string(255)     
#  url                             :string(255)     
#  permalink                       :string(255)     
#  google_analytics_id             :string(255)     
#  logo_file_name                  :string(255)     
#  logo_content_type               :string(255)     
#  logo_file_size                  :integer         
#  logo_updated_at                 :datetime        
#  theme_id                        :integer         
#  blog_url                        :string(255)     
#  word_for_clusters               :string(255)     
#  word_for_regions                :string(255)     
#  show_global_donations_raises    :boolean         
#  project_classification          :integer         default(0)
#  geographic_context_country_id   :integer         
#  geographic_context_region_id    :integer         
#  project_context_cluster_id      :integer         
#  project_context_organization_id :integer         
#  project_context_tags            :string(255)     
#  created_at                      :datetime        
#  updated_at                      :datetime        
#  geographic_context_geometry     :geometry        
#  project_context_tags_ids        :string(255)     
#

class Site < ActiveRecord::Base

  acts_as_geom :the_geom => :polygon

  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::SITE_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_one :theme
  has_many :partners, :dependent => :destroy

  has_attached_file :logo, :styles => { :small => "60x60#" }

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  before_validation :clean_html

  attr_accessor :geographic_context, :project_context, :show_blog

  before_save :set_geographic_context, :set_project_context, :set_project_context_tags_ids

  def show_blog
    !blog_url.blank?
  end
  alias :show_blog? :show_blog

  private

    def clean_html
      %W{ name short_description long_description contact_person contact_email url permalink }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

    def set_geographic_context
      unless geographic_context.blank?
        case geographic_context
        when 'worlwide'
          self.geographic_context_country_id = nil
          self.geographic_context_region_id  = nil
          self.geographic_context_geometry   = nil
        when 'country'
          self.geographic_context_region_id  = nil
          self.geographic_context_geometry   = nil
        when 'region'
          self.geographic_context_country_id = nil
          self.geographic_context_geometry   = nil
        when 'bbox'
          self.geographic_context_geometry   = nil
        end
      end
    end

    def set_project_context
      return if project_context.blank?
      unless project_context.include?('tags')
        self.project_context_tags = nil
      end
      unless project_context.include?('cluster')
        self.project_context_cluster_id = nil
      end
      unless project_context.include?('organization')
        self.project_context_organization_id = nil
      end
    end

    def set_project_context_tags_ids
      return if project_context_tags.blank?
      tag_names = project_context_tags.split(',').map{ |t| t.strip }.compact.delete_if{ |t| t.blank? }
      self.project_context_tags_ids = tag_names.map{ |tag_name| Tag.find_by_name(tag_name).id }.compact.join(',')
    end

end
