class Organization
  include ModelChangesRecorder

  attr_accessor :id, :name, :name_was, :user
  attr_accessor :changes_history_records, :changes
  attr_accessor :things, :new_things

  def initialize
    self.things          = []
    self.new_things      = things.length
    self.changes         = []
    self.changes_history_records = []
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

    change = {}
    change[:name] = [ self.name_was, self.name ] if new_attributes[:name].present?
    changes << change

    save
  end

  def save
    if things.length != new_things
      record_new_associated_object('things', things.last(things.length - new_things))
      self.new_things = things.length
    end

    record_changes
  end

end
