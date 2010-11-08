# == Schema Information
#
# Table name: projects
#
#  id             :integer         not null, primary key
#  ngo_id         :integer         
#  name           :string(255)     
#  description    :text            
#  cluster_id     :integer         
#  start_date     :date            
#  end_date       :date            
#  people_reached :integer         
#  area_covered   :float           
#  created_at     :datetime        
#  updated_at     :datetime        
#  the_geom       :geometry        
#

class Project < ActiveRecord::Base

  belongs_to :cluster
  belongs_to :ngo

  has_many :donations
  has_many :donors, :through => :donations

end
