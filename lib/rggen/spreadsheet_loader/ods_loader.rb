# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class ODSLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:ods]

      def read_spreadsheet(file, book)
        SpreadBase::Document.new(file)
          .tables.each { |table| process_table(table, book) }
      end

      private

      def process_table(table, book)
        rows = table.data
        rows.size.positive? && book.add_sheet(table.name, rows)
      end
    end
  end
end
