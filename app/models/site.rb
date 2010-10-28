# == Schema Information
#
# Table name: sites
#
#  id                :integer         not null, primary key
#  name              :string(255)     
#  short_description :text            
#  long_description  :text            
#  contact_email     :string(255)     
#  contact_person    :string(255)     
#  url               :string(255)     
#  permalink         :string(255)     
#  has_blog          :boolean         
#  created_at        :datetime        
#  updated_at        :datetime        
#  the_geom          :geometry        
#

class Site < ActiveRecord::Base
end
