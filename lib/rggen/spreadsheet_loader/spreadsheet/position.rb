# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Position
        def initialize(file, sheet, row, column)
          @file = file
          @sheet = sheet
          @row = row
          @column = column
        end

        attr_reader :file
        attr_reader :sheet

        def row
          @row + 1
        end

        def column
          @column.times.inject('A') { |l, _| l.next }
        end

        def to_s
          "file: #{file} sheet: #{sheet} row: #{row} column: #{column}"
        end
      end
    end
  end
end
