class ChangesHistoryRecord < ActiveRecord::Base
  belongs_to :who, :class_name => 'User'
  belongs_to :what, :polymorphic => true
end
