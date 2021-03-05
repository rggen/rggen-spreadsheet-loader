# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class XLSXLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx]

      def read_spreadsheet(file, book)
        require 'creek'
        Creek::Book.new(file).sheets.each do |sheet|
          table = read_table(sheet)
          table.size.positive? && book.add_sheet(sheet.name, table)
        end
      end

      private

      def read_table(sheet)
        sheet.simple_rows_with_meta_data.each_with_object([]) do |row, rows|
          index = row['r'].to_i
          (index - rows.size - 1).times { rows << nil }
          rows << row['cells'].values
        end
      end
    end
  end
end
