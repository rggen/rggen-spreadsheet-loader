module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Sheet
        def initialize(book, sheet)
          @file = book.file
          @sheet = sheet
          @rows = []
        end

        attr_reader :file
        attr_reader :sheet

        def [](row, column = nil)
          @rows[row] ||= Row.new(self, row)
          (column && @rows[row][column]) || @rows[row]
        end

        def from_table(table)
          table.each_with_index do |row, row_index|
            row.each_with_index do |value, column_index|
              self[row_index][column_index] = value
            end
          end
        end

        def rows(from = 0, length = nil)
          Array.new(length || (@rows.size - from)) { |i| self[from + i] }
        end
      end
    end
  end
end
