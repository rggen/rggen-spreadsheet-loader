# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class XLSLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xls]

      def read_spreadsheet(file, book)
        read_xls(file).each do |sheet|
          book.add_sheet(sheet.name, sheet.rows)
        end
      end

      private

      def read_xls(file)
        require 'spreadsheet'
        ::Spreadsheet.open(file, 'rb') do |book|
          book.worksheets.select { |sheet| sheet.row_count > 0 }
        end
      end
    end
  end
end
