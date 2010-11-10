# == Schema Information
#
# Table name: projects
#
#  id                        :integer         not null, primary key
#  name                      :string(255)     
#  description               :text            
#  primary_organization      :integer         
#  implementing_organization :string(255)     
#  partner_organization      :string(255)     
#  cross_cutting_issues      :string(255)     
#  start_date                :date            
#  end_date                  :date            
#  budget                    :integer         
#  region_id                 :integer         
#  target                    :string(255)     
#  people_reached            :integer         
#  contact_person            :string(255)     
#  contact_email             :string(255)     
#  contact_phone             :string(255)     
#  site_specific_information :text            
#  created_at                :datetime        
#  updated_at                :datetime        
#  the_geom                  :geometry        
#

class Project < ActiveRecord::Base

  belongs_to :cluster
  belongs_to :ngo

  has_many :donations
  has_many :donors, :through => :donations

end
