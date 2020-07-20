# frozen_string_literal: true

require_relative 'spreadsheet_loader/version'
require_relative 'spreadsheet_loader/spreadsheet/position'
require_relative 'spreadsheet_loader/spreadsheet/cell'
require_relative 'spreadsheet_loader/spreadsheet/row'
require_relative 'spreadsheet_loader/spreadsheet/sheet'
require_relative 'spreadsheet_loader/spreadsheet/book'
require_relative 'spreadsheet_loader/spreadsheet_loader'
require_relative 'spreadsheet_loader/csv_loader'
require_relative 'spreadsheet_loader/roo_loader'
require_relative 'spreadsheet_loader/xls_loader'

module RgGen
  module SpreadsheetLoader
    def self.default_setup(builder)
      builder.register_loader(:register_map, :spreadsheet, CSVLoader)
      builder.register_loader(:register_map, :spreadsheet, RooLoader)
      builder.register_loader(:register_map, :spreadsheet, XLSLoader)
    end
  end
end
