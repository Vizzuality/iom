class CreateClusters < ActiveRecord::Migration
  def self.up
    create_table :clusters do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :clusters
  end
end
