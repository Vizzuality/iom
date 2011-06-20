module CsvMethods
  def serialize_to_csv(options = {})
    return '' unless self.any?
    FasterCSV.generate do |csv|
      csv << options[:headers]
      self.each do |item|
        csv << (item.csv_columns rescue item.values)
      end
    end
  end
end
class Array;                    include CsvMethods; end
class PGresult;                 include CsvMethods; end