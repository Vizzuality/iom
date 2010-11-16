# == Schema Information
#
# Table name: resources
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  url          :string(255)
#  element_id   :integer
#  element_type :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Resource < ActiveRecord::Base

  PROJECT_TYPE      = 0
  ORGANIZATION_TYPE = 1
  DONOR_TYPE        = 2

  belongs_to :project, :foreign_key => :element_id
  belongs_to :organization, :foreign_key => :element_id
  belongs_to :donor, :foreign_key => :element_id

  validates_presence_of :title, :url, :element_type, :element_id
  validates_uniqueness_of :title, :scope => [:element_type, :element_id]
  validates_uniqueness_of :url,   :scope => [:element_type, :element_id]

  def project=(project)
    self.element_type = PROJECT_TYPE
    self.element_id   = project.id
  end

  def organization=(organization)
    self.element_type = ORGANIZATION_TYPE
    self.element_id   = organization.id
  end

  def donor=(donor)
    self.element_type = DONOR_TYPE
    self.element_id   = donor.id
  end

  def element=(element)
    self.element_id   = element.id
    self.element_type = eval("#{element.class.name.upcase}_TYPE")
  end

end
