module Iom
  module Data

    def create_sector(attributes = {})
      Sector.create! attributes
    end

  end
end