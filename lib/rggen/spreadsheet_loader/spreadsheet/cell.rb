# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Cell < Core::InputBase::InputValue
        def initialize(value, row, column)
          position = Position.new(row.file, row.sheet, row.row, column)
          super(value, position)
        end

        alias_method :empty_cell?, :empty_value?
      end

      class EmptyCell < Cell
        def initialize(row, column)
          super(nil, row, column)
        end
      end
    end
  end
end
