# == Schema Information
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#

require 'digest/sha1'

class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  belongs_to :organization

  before_save :set_role

  validates :email, :presence   => true,
                    :uniqueness => true,
                    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                    :length     => { :within => 6..100 }



  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation

  # Authenticates a user by their email name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase.strip) # need to get the salt
    u && u.authenticated?(password.strip) ? u : nil
  end

  def self.admin
    where(:role => 'admin').first
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def password=(value)
    write_attribute :password, (value ? value.strip : nil)
  end

  def password_confirmation=(value)
    write_attribute :password_confirmation, (value ? value.strip : nil)
  end

  def admin?
    self.role.present? && self.role == 'admin'
  end
  alias administrator? admin?

  def not_blocked?
    !self.blocked?
  end

  def to_s
    "#{[email, (organization.name rescue 'InterAction')].compact.join(' - ') }"
  end

  def organization_name
    (organization.name rescue 'InterAction')
  end

  def set_role
    self.role = 'organization' if self.id != 1
  end
  private :set_role

end
