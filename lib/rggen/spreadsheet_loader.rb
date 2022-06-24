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
require_relative 'spreadsheet_loader/xls_loader'
require_relative 'spreadsheet_loader/xlsx_loader'

RgGen.setup_plugin :'rggen-spreadsheet-loader' do |plugin|
  plugin.version RgGen::SpreadsheetLoader::VERSION
  plugin.setup_loader :register_map, :spreadsheet do |entry|
    entry.register_loaders [
      RgGen::SpreadsheetLoader::CSVLoader,
      RgGen::SpreadsheetLoader::ODSLoader,
      RgGen::SpreadsheetLoader::XLSLoader,
      RgGen::SpreadsheetLoader::XLSXLoader
    ]

    entry.ignore_value :register_block, :comment
    entry.ignore_value :register, :comment
  end
end
