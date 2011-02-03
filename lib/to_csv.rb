module CsvMethods
  def serialize_to_csv(options = {})
    return '' unless self.any?
    FasterCSV.generate(:col_sep => ';') do |csv|
      csv << options[:headers]
      self.each do |item|
        csv << item.csv_columns
      end
    end
  end
end
class Array;                    include CsvMethods; end
class PGresult;                 include CsvMethods; end