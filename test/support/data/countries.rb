module Iom
  module Data

    def create_country(attributes = {})
      Country.create! attributes
    end

  end
end