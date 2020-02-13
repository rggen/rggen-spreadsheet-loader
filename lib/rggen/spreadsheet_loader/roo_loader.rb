# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class RooLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx, :ods]

      def read_spreadsheet(file, book)
        read_roo(file) do |pagename, page|
          book.add_sheet(pagename, collect_cells(page))
        end
      end

      private

      def read_roo(file)
        require 'roo'
        Roo::Spreadsheet.open(file, extension: File.extname(file))
          .each_with_pagename do |pagename, page|
            page.first_row && yield(pagename, page)
          end
      end

      def collect_cells(page)
        (1..page.last_row).map do |row|
          (1..page.last_column).map { |column| page.cell(row, column) }
        end
      end
    end
  end
end
