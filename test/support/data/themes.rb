module Iom
  module Data

    def create_theme(attributes = {})
      Theme.create :name => 'Blue',
                   :css_file => '/stylesheets/themes/blue.css',
                   :thumbnail_path => '/images/themes/3/thumbnail.png'
    end

  end
end