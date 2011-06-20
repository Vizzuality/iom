require 'spreadsheet'

module ExcelMethods

  def to_excel(options = {})
    output = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    return nil unless self.any?

    sheet.row(0).concat options[:headers]

    self.each_with_index do |row, index|
      case row
      when ::Hash
        sheet.row(index + 1).concat row.values
      when ::Array
        sheet.row(index + 1).concat row
      end
    end

    book.write output
    output.string
  end

end
class Array;                    include ExcelMethods; end
class PGresult;                 include ExcelMethods; end