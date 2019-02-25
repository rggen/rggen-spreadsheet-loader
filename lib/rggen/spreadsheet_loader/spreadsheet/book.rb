module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Book
        def initialize(file)
          @file = file
          @sheets = []
          block_given? && yield(self)
        end

        attr_reader :file
        attr_reader :sheets

        def add_sheet(sheet_name, table)
          sheet = Sheet.new(self, sheet_name)
          sheet.from_table(table)
          sheets << sheet
        end
      end
    end
  end
end
