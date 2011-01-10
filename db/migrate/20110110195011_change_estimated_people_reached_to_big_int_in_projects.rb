class ChangeEstimatedPeopleReachedToBigIntInProjects < ActiveRecord::Migration
  def self.up
    VProjectsDenormalized.drop
    change_column :projects, :estimated_people_reached, :integer, :limit => 8
    VProjectsDenormalized.create
  end

  def self.down
    VProjectsDenormalized.drop
    change_column :projects, :estimated_people_reached, :integer
    VProjectsDenormalized.create
  end
end
