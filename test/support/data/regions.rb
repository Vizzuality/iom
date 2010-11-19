module Iom
  module Data

    def create_region(attributes = {})
      Region.create! attributes
    end

  end
end