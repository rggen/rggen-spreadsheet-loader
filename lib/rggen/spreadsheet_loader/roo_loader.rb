module RgGen
  module SpreadsheetLoader
    class RooLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx, :xls, :ods, :csv]

      def read_spreadsheet(file, book)
        Roo::Spreadsheet.open(file).each_with_pagename do |pagename, page|
          page.first_row && book.add_sheet(pagename, collect_cells(page))
        end
      end

      private

      def collect_cells(page)
        (1..page.last_row).map do |row|
          (1..page.last_column).map { |column| page.cell(row, column) }
        end
      end
    end
  end
end
