# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    class RooLoader < Core::RegisterMap::Loader
      include SpreadsheetLoader

      support_types [:xlsx, :ods]

      def read_spreadsheet(file, book)
        read_roo(file, &page_processor(book))
      end

      private

      def read_roo(file, &block)
        require 'roo'
        Roo::Spreadsheet.open(file, extension: File.extname(file))
          .each_with_pagename(&block)
      end

      def page_processor(book)
        lambda do |pagename_and_page|
          pagename, page = pagename_and_page
          page.first_row && book.add_sheet(pagename, collect_cells(page))
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
