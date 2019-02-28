# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Cell < Core::InputBase::InputValue
        def initialize(row, column)
          position = Position.new(row.file, row.sheet, row.row, column)
          super(nil, position)
        end

        alias_method :empty_cell?, :empty_value?
      end
    end
  end
end
