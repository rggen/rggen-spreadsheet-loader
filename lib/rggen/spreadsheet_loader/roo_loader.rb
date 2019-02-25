module RgGen
  module SpreadsheetLoader
    class RooLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx, :xls, :ods, :csv]

      def read_spreadsheet(file, book)
        Roo::Spreadsheet.open(file).each_with_pagename do |pagename, page|
          page.first_row && parse_page(pagename, page, book)
        end
      end

      private

      def parse_page(pagename, page, book)
        book.add_sheet(pagename, page.to_table(from_row: 1, from_column: 1))
      end
    end
  end
end
