module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Row
        def initialize(sheet, row)
          @file = sheet.file
          @sheet = sheet.sheet
          @row = row
          @cells = []
        end

        attr_reader :file
        attr_reader :sheet
        attr_reader :row

        def [](column)
          @cells[column] ||= Cell.new(self, column)
          @cells[column]
        end

        def []=(column, value)
          self[column].value = value
        end

        def cells(from = 0, length = nil)
          Array.new(length || (@cells.size - from)) { |i| self[from + i] }
        end
      end
    end
  end
end
