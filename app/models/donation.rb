# == Schema Information
#
# Table name: donations
#
#  id         :integer         not null, primary key
#  donor_id   :integer         
#  project_id :integer         
#  amount     :integer         
#  created_at :datetime        
#  updated_at :datetime        
#

class Donation < ActiveRecord::Base

  belongs_to :donor
  belongs_to :project

end
