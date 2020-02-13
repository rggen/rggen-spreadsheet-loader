# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class CSVLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:csv]

      def read_spreadsheet(file, book)
        sheet = read_csv(file)
        sheet_name = File.basename(file, '.*')
        book.add_sheet(sheet_name, sheet)
      end

      private

      def read_csv(file)
        require 'csv'
        CSV.read(file)
      end
    end
  end
end
