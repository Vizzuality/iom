module CsvMethods
  def serialize_to_csv(options = {})
    return '' unless self.any?

    klass      = self.first.class
    keys       = self.first.is_a?(Hash) ? self.first.keys : self.first.attributes.keys
    attributes = keys.sort.map(&:to_sym)

    if options[:only]
      columns = Array(options[:only]) & attributes
    else
      columns = attributes - Array(options[:except])
    end

    columns += Array(options[:methods])

    return '' if columns.empty?

    output = FasterCSV.generate do |csv|
      csv << columns unless options[:headers] == false
      self.each do |item|
        row = item.is_a?(Hash) ? OpenStruct.new(item) : item
        csv << columns.collect { |column| row.send(column) }
      end
    end

    output
  end
end
class Array;                    include CsvMethods; end
class PGresult;                 include CsvMethods; end