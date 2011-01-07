class ChangeBudgetFieldToFloatInProjects < ActiveRecord::Migration
  def self.up
    VProjectsDenormalized.drop
    change_column :projects, :budget, :float
    VProjectsDenormalized.create
  end

  def self.down
    VProjectsDenormalized.drop
    # change_column :projects, :budget, :integer
    VProjectsDenormalized.create
  end
end
