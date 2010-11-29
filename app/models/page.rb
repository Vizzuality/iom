# == Schema Information
#
# Table name: pages
#
#  id          :integer         not null, primary key
#  title       :string(255)     
#  body        :text            
#  site_id     :integer         
#  highlighted :boolean         
#  permalink   :string(255)     
#  created_at  :datetime        
#  updated_at  :datetime        
#  parent_id   :integer         
#

class Page < ActiveRecord::Base

  belongs_to :site

  validates_presence_of   :title
  validates_uniqueness_of :permalink, :scope => [:site_id]
  validates_uniqueness_of :title, :scope => [:site_id]

  before_create :set_permalink

  scope :parents, where(:parent_id => nil)

  def children
    Page.where(:parent_id => self.id)
  end

  def to_param
    permalink
  end

  def self.about(site)
    site.pages.find_by_title('About')
  end

  def self.contact(site)
    site.pages.find_by_title('Contact')
  end

  def self.analysis(site)
    site.pages.find_by_title('Analysis')
  end

  private

    def set_permalink
      self.permalink = self.title.sanitize unless self.title.blank?
    end

end
