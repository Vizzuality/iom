module Iom
  module Data

    def default_user_attributes
      {:email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'}
    end

    def new_user(attributes = {})
      User.new(default_user_attributes.merge(attributes))
    end

    def create_user(attributes = {})
      user = new_user(attributes)
      user.save!
      user.reload
    end

  end
end