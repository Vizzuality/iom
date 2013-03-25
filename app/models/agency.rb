class Agency < ActiveRecord::Base
  belongs_to :donor
  has_many :donations
  has_many :projects, :through => :donations
end
