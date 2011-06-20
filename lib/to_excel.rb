require 'spreadsheet'

module ExcelMethods

  def to_excel(options = {})
    return nil unless self.any?

    output   = StringIO.new ''
    book     = Spreadsheet::Workbook.new
    sheet    = book.create_worksheet
    headers  = options[:headers]
    init_row = 0

    if headers
      init_row = 1
      sheet.row(0).concat headers
    end

    self.each_with_index do |row, row_index|
      case row
      when ::Hash
        if headers
          headers.each_with_index do |field_name, column_index|
            sheet[row_index + init_row, column_index] = row[field_name]
          end
        else
          sheet.row(row_index + init_row).concat row.values
        end
      when ::Array
        sheet.row(row_index + init_row).concat row
      end
    end

    book.write output
    output.string
  end

end
class Array;                    include ExcelMethods; end
class PGresult;                 include ExcelMethods; end