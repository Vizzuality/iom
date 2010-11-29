# == Schema Information
#
# Table name: projects
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  description               :text
#  primary_organization_id   :integer
#  implementing_organization :string(255)
#  partner_organizations     :string(255)
#  cross_cutting_issues      :string(255)
#  start_date                :date
#  end_date                  :date
#  budget                    :integer
#  target                    :string(255)
#  estimated_people_reached  :integer
#  contact_person            :string(255)
#  contact_email             :string(255)
#  contact_phone_number      :string(255)
#  site_specific_information :text
#  created_at                :datetime
#  updated_at                :datetime
#  activities                :text
#  intervention_id           :string(255)
#  additional_information    :text
#  awardee_type              :string(255)
#  the_geom                  :geometry        not null
#

class Project < ActiveRecord::Base

  acts_as_geom :the_geom => :multi_point

  belongs_to :primary_organization, :foreign_key => :primary_organization_id, :class_name => 'Organization'
  has_and_belongs_to_many :clusters
  has_and_belongs_to_many :sectors
  has_and_belongs_to_many :regions, :after_add => :add_to_country, :after_remove => :remove_from_country
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :tags, :after_add => :update_tag_counter, :after_remove => :update_tag_counter
  has_many :resources, :conditions => 'resources.element_type = #{Iom::ActsAsResource::PROJECT_TYPE}', :foreign_key => :element_id, :dependent => :destroy
  has_many :media_resources, :conditions => 'media_resources.element_type = #{Iom::ActsAsResource::PROJECT_TYPE}', :foreign_key => :element_id, :dependent => :destroy, :order => 'position ASC'
  has_many :donations, :dependent => :destroy
  has_many :donors, :through => :donations

  before_validation :clean_html

  validates_presence_of :name, :description

  validate :dates_consistency

  def sectors_ids=(value)
    value.each do |sector_id|
      if sector = Sector.find(sector_id)
        sectors << sector
      end
    end
  end

  def clusters_ids=(value)
    value.each do |cluster_id|
      if cluster = Cluster.find(cluster_id)
        clusters << cluster
      end
    end
  end

  def tags=(tag_names)
    return if tag_names.blank?
    if tag_names.is_a?(String)
      tag_names = tag_names.split(',').map{ |t| t.strip }.compact.delete_if{ |t| t.blank? }
    end
    Tag.transaction do
      tags.clear
      tag_names.each do |tag_name|
        if tag = Tag.find_by_name(tag_name)
          unless tags.include?(tag)
            tags << tag
          end
        else
          tag = Tag.create :name => tag_name
          tags << tag
        end
      end
    end
  end

  def update_tag_counter(tag)
    tag.update_tag_counter
  end

  # TODO: remove this when reverse geocoding
  #  - reverse geocoding
  def before_save
    self.the_geom = MultiPoint.from_points([Point.from_x_y(0, -77)])
  end

  def finished?
    end_date < Date.today
  end

  def months_left
    unless finished?
      (end_date - Date.today).to_i / 30
    end
  end

  private

    def clean_html
      %W{ name description implementing_organization partner_organizations cross_cutting_issues target contact_person contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

    def dates_consistency
      return true if end_date.nil? || start_date.nil?
      if end_date < start_date
        errors.add(:end_date, "can't be previous to start_date")
      end
    end

    def add_to_country(region)
      countries << region.country unless countries.include?(region.country)
    end

    def remove_from_country(region)
      countries.delete(region.country)
    end

end
