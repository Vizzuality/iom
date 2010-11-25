# == Schema Information
#
# Table name: clusters
#
#  id   :integer         not null, primary key
#  name :string(255)     
#

class Cluster < ActiveRecord::Base

  has_and_belongs_to_many :projects

  def donors
    projects.map do |project|
      project.donors
    end.flatten.uniq
  end

end
