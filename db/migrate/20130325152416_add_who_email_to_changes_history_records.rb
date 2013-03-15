class AddWhoEmailToChangesHistoryRecords < ActiveRecord::Migration
  def self.up
    add_column :changes_history_records, :who_email, :string
    puts
    puts 'Updating existing changes history records...'
    ChangesHistoryRecord.find_each(:batch_size => 100) do |change|
      print '.'
      next unless change.who.present?
      change.who_email = change.who.email
      change.save
    end
    puts
    puts '... done!'
  end

  def self.down
    remove_column :changes_history_records, :who_email
  end
end
