module Iom
  module Data

    def create_tag(attributes = {})
      Tag.create! attributes
    end

  end
end