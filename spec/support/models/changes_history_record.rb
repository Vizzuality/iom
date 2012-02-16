class ChangesHistoryRecord
  attr_accessor :who, :what, :how

  def self.create!(attributes = {})
    change = self.new
    change.what = attributes[:what] rescue nil
    change.who  = change.what.updated_by rescue nil
    change.how  = attributes[:how]  rescue nil
    change
  end
end
