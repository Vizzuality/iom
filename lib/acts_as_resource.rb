module Iom
  module ActsAsResource

    PROJECT_TYPE      = 0
    ORGANIZATION_TYPE = 1
    DONOR_TYPE        = 2

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def acts_as_resource(options = {})
        belongs_to :project, :foreign_key => :element_id
        belongs_to :organization, :foreign_key => :element_id
        belongs_to :donor, :foreign_key => :element_id

        send :include, InstanceMethods
      end
    end

    module InstanceMethods
      def element=(element)
        self.element_id   = element.id
        self.element_type = eval("Iom::ActsAsResource::#{element.class.name.upcase}_TYPE")
      end
    end

  end
end

ActiveRecord::Base.send :include, Iom::ActsAsResource