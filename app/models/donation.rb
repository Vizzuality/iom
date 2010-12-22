# == Schema Information
#
# Table name: donations
#
#  id         :integer         not null, primary key
#  donor_id   :integer         
#  project_id :integer         
#  amount     :float           
#  date       :date            
#

class Donation < ActiveRecord::Base

  belongs_to :project
  belongs_to :donor

  validates_presence_of :donor, :project

end
