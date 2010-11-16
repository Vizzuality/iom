# == Schema Information
#
# Table name: tags
#
#  id    :integer         not null, primary key
#  name  :string(255)     
#  count :integer         default(0)
#

class Tag < ActiveRecord::Base

  has_and_belongs_to_many :projects, :after_add => :update_tag_counter, :after_remove => :update_tag_counter

  validates_uniqueness_of :name

  def update_tag_counter
    self.class.transaction do
      update_attribute(:count, projects.count)
    end
  end

end
