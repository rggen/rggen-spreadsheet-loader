# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class CSVLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:csv, :tsv]

      def read_spreadsheet(file, book)
        sheet = read_csv(file)
        sheet_name = File.basename(file, '.*')
        book.add_sheet(sheet_name, sheet)
      end

      private

      def read_csv(file)
        CSV.read(file, col_sep: separator(file))
      end

      def separator(file)
        ext = File.extname(file)
        ext.casecmp?('.tsv') && "\t" || ','
      end
    end
  end
end
