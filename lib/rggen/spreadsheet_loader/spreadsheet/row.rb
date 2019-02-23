module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Row
        def initialize(file, sheet, row_index)
          @file = file
          @sheet = sheet
          @row_index = row_index
          @cells = []
        end

        def [](column_index)
          @cells[column_index] ||= Cell.new(
            @file, @sheet, @row_index, column_index
          )
          @cells[column_index]
        end

        def []=(column_index, value)
          self[column_index].value = value
        end

        def cells(from = 0, length = nil)
          Array.new(length || (@cells.size - from)) { |i| self[from + i] }
        end
      end
    end
  end
end
