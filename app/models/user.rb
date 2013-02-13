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

  validates :name, :presence   => true
  validates :email, :presence   => true,
                    :uniqueness => true,
                    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                    :length     => { :within => 6..100 }

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation, :description, :organization_id, :site_id, :role

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
    @password = value ? value.strip : nil
  end

  def password_confirmation=(value)
    @password_confirmation = value ? value.strip : nil
  end

  def admin?
    self.organization.blank?
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

  def site_id=(value)
    write_attribute :site_id, value.join(',')
  end

  def site_id
    @site_id ||= (attributes['site_id'] || '').split(',')
  end

  def update_password(password, password_confirmation)
    self.password               = password
    self.password_confirmation  = password_confirmation
    self.password_reset_sent_at = nil
    self.password_reset_token   = nil
    self.save
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    AlertsMailer.reset_password(email, password_reset_token).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.base64
    end while User.exists?(column => self[column])
  end
  private :generate_token

end
