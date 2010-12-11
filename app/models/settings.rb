# == Schema Information
#
# Table name: settings
#
#  id   :integer         not null, primary key
#  data :text            
#

class Settings < ActiveRecord::Base
  
  serialize :data, Hash
  
  def data
    self[:data] ||= HashWithIndifferentAccess.new
  end
  
  def self.main_site_host
    first.data[:main_site_host]
  end
  
end
