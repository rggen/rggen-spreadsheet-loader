# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module Spreadsheet
      Position = Struct.new(:file, :sheet, :row, :column) do
        def to_s
          to_h
            .map { |field, value| "#{field}: #{value}" }
            .join(' ')
        end
      end
    end
  end
end
