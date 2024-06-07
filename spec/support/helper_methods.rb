# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module HelperMethods
      def match_cell_position(file, sheet, row, column)
        be_instance_of(RgGen::SpreadsheetLoader::Spreadsheet::Position)
          .and have_attributes(file: file, sheet: sheet, row: row + 1, column: column_letter(column))
      end

      def column_letter(column)
        column.times.inject('A') { |l, _| l.next }
      end
    end
  end
end
