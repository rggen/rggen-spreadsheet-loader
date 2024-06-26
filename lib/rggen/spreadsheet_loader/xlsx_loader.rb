# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class XLSXLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx]

      def read_spreadsheet(file, book)
        SimpleXlsxReader.open(file)
          .sheets.each { |sheet| process_sheet(sheet, book) }
      end

      private

      def process_sheet(sheet, book)
        sheet.rows.count.positive? &&
          book.add_sheet(sheet.name, sheet.rows)
      end
    end
  end
end
