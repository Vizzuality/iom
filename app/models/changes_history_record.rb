class ChangesHistoryRecord < ActiveRecord::Base
  belongs_to :who, :class_name => 'User', :foreign_key => :user_id
  belongs_to :what, :polymorphic => true

  def self.in_last_24h
    where('changes_history_records.user_id <> ? AND changes_history_records.when > ?', User.admin.id, 1.day.ago)
  end

  def changes
    @changes ||= JSON.parse(how) if how.present?
  end

  def changes_count
    changes.keys.count rescue 0
  end

  def what_name
    what.name rescue ''
  end

  def who_email
    who.email rescue ''
  end

  def who_organization
    who.organization
  end

  def who_organization_name
    who_organization.name rescue 'Interaction'
  end
end
