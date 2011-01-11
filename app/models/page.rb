# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string(255)     
#  body       :text            
#  site_id    :integer         
#  published  :boolean         
#  permalink  :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#  parent_id  :integer         
#

class Page < ActiveRecord::Base

  belongs_to :site

  validates_presence_of   :title
  validates_uniqueness_of :permalink, :scope => [:site_id]
  validates_uniqueness_of :title, :scope => [:site_id]

  before_create :set_permalink, :set_status
  before_destroy :set_children_parent

  scope :published, where(:published => true)
  scope :highlighted, where(:parent_id => nil)

  def children
    Page.where(:parent_id => self.id).order("order_index ASC")
  end

  def  parent
    if parent_id?
      Page.find(parent_id)
    end
  end

  def top_parent
    parent_page = self
    while parent_page.parent
      parent_page = parent_page.parent
    end
    parent_page
  end

  def to_param
    permalink
  end

  def self.from_param(param)
    scoped.where(:permalink => param).first
  end

  def self.about(site)
    site.pages.find_by_title('About')
  end

  def self.contact(site)
    site.pages.find_by_title('Contact')
  end

  def self.highlights(site)
    site.pages.find_by_title('Highlights')
  end

  def set_status
    self.published ||= true
  end

  private

    def set_permalink
      self.permalink = self.title.sanitize unless self.title.blank?
    end

    def set_children_parent
      return if children.empty?
      children.each do |child|
        child.update_attribute(:parent_id, nil)
      end
    end

end
