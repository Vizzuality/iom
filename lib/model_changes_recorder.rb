module ModelChangesRecorder

  def self.included(base)

    base.class_eval do
      has_many  :changes_history_records
    end if defined?(ActiveRecord::Base) && base.is_a?(ActiveRecord::Base)

    base.send :include, InstanceMethods
    base.send :extend, ClassMethods
  end

  module InstanceMethods
    def record_changes
      self.changes_history_records << Change.create!(:who => self.user, :what => self, :how => self.changes.to_json)
    end
  end

  module ClassMethods

  end

end
