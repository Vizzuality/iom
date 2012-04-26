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

  accepts_nested_attributes_for :donor

  def amount=(ammount)
    if ammount.blank?
      write_attribute(:ammount, 0)
    else
      case ammount
        when String then write_attribute(:amount, ammount.delete(',').to_f)
        else             write_attribute(:amount, ammount)
      end
    end
  end

  def change_label
    [donor.name, date.strftime("%m/%d/%Y"), "$#{amount}"].join(' -  ')
  end

end
