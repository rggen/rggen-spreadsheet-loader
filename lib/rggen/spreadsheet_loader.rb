# frozen_string_literal: true

require_relative 'spreadsheet_loader/version'
require_relative 'spreadsheet_loader/spreadsheet/position'
require_relative 'spreadsheet_loader/spreadsheet/cell'
require_relative 'spreadsheet_loader/spreadsheet/row'
require_relative 'spreadsheet_loader/spreadsheet/sheet'
require_relative 'spreadsheet_loader/spreadsheet/book'
require_relative 'spreadsheet_loader/spreadsheet_loader'
require_relative 'spreadsheet_loader/csv_loader'
require_relative 'spreadsheet_loader/ods_loader'
require_relative 'spreadsheet_loader/roo_loader'
require_relative 'spreadsheet_loader/xls_loader'
require_relative 'spreadsheet_loader/xlsx_loader'

module RgGen
  module SpreadsheetLoader
    extend Core::Plugin

    setup_plugin :'rggen-spreadsheet-loader' do |plugin|
      [CSVLoader, ODSLoader, RooLoader, XLSLoader, XLSXLoader].each do |loader|
        plugin.register_loader :register_map, :spreadsheet, loader
      end
    end
  end
end
