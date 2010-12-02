class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string    :title
      t.text      :body
      t.integer   :site_id
      t.boolean   :published
      t.string    :permalink
      t.timestamps
    end
    add_index :pages, :site_id
    add_index :pages, :permalink
  end

  def self.down
    drop_table :pages
  end
end
