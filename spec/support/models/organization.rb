class Organization
  include ModelChangesRecorder

  attr_accessor :id, :name, :name_was, :description, :description_was, :budget, :budget_was, :user
  attr_accessor :changes_history_records, :changes
  attr_accessor :things, :new_things

  def initialize
    self.things          = []
    self.new_things      = things.length
    self.changes         = {}
    self.changes_history_records = []
    self.changed_attributes = {}
  end

  def changed_attributes
    changes
  end

  def changed_attributes=(values)
    self.changes = values
  end

  def name=(value)
    return if value.blank?
    self.name_was = @name
    @name = value
  end

  def self.create(attributes = {})
    organization = self.new

    organization.id          = 1
    organization.name        = attributes[:name]        rescue nil

    organization
  end

  def update_attributes(new_attributes = {})
    self.name        = new_attributes[:name]        rescue nil
    self.description = new_attributes[:description] rescue nil
    self.budget      = new_attributes[:budget] rescue nil

    changed_attributes[:name]        = [ self.name_was, self.name ]               if new_attributes[:name].present?
    changed_attributes[:description] = [ self.description_was, self.description ] if new_attributes[:description].present?
    changed_attributes[:budget]      = [ self.budget_was, self.budget ]           if new_attributes[:budget].present?

    save
  end

  def save
    if things.length != new_things
      things.last(things.length - new_things).each do |thing|
        record_new_associated_object(thing)
      end
      self.new_things = things.length
    end

    record_changes
  end

end
