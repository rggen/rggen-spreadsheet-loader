# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class ODSLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:ods]

      def read_spreadsheet(file, book)
        require 'spreadbase'
        SpreadBase::Document.new(file).tables.each do |table|
          data = table.data
          data.size.positive? && book.add_sheet(table.name, data)
        end
      end
    end
  end
end
