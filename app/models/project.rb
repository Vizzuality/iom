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
#  stimated_people_reached   :integer
#  contact_person            :string(255)
#  contact_email             :string(255)
#  contact_phone_number      :string(255)
#  site_specific_information :text
#  created_at                :datetime
#  updated_at                :datetime
#  the_geom                  :geometry        not null
#

class Project < ActiveRecord::Base

  acts_as_geom :the_geom => :multi_point

  belongs_to :primary_organization, :foreign_key => :primary_organization_id, :class_name => 'Organization'
  has_and_belongs_to_many :secondary_organizations, :class_name => 'Organization', :join_table => 'organizations_projects'
  has_and_belongs_to_many :clusters
  has_and_belongs_to_many :sectors
  has_and_belongs_to_many :tags, :after_add => :update_tag_counter, :after_remove => :update_tag_counter

  before_validation :clean_html

  validates_presence_of :name

  def tag_with(tag_names)
    raise "tag names can't be blank or nil" if tag_names.blank?
    if tag_names.is_a?(String)
      tag_names = tag_names.split(',').map{ |t| t.strip }
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

  private

    def clean_html
      %W{ name description implementing_organization partner_organizations cross_cutting_issues target contact_person contact_email contact_phone_number }.each do |att|
        eval("self.#{att} = Sanitize.clean(self.#{att}.gsub(/\r/,'')) unless self.#{att}.blank?")
      end
    end

end
