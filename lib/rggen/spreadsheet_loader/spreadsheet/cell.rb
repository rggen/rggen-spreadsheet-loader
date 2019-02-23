module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      class Cell < Core::InputBase::InputValue
        def initialize(file, sheet, row, column)
          position = Position.new(file, sheet, row, column)
          super(nil, position)
        end

        alias_method :empty_cell?, :empty_value?
      end
    end
  end
end
