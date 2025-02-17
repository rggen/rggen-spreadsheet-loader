# frozen_string_literal: true

autoload :CSV, 'csv'
autoload :SimpleXlsxReader, 'simple_xlsx_reader'
autoload :SpreadBase, 'spreadbase'

require_relative 'spreadsheet_loader/version'
require_relative 'spreadsheet_loader/spreadsheet/position'
require_relative 'spreadsheet_loader/spreadsheet/cell'
require_relative 'spreadsheet_loader/spreadsheet/row'
require_relative 'spreadsheet_loader/spreadsheet/sheet'
require_relative 'spreadsheet_loader/spreadsheet/book'
require_relative 'spreadsheet_loader/spreadsheet_loader'
require_relative 'spreadsheet_loader/csv_loader'
require_relative 'spreadsheet_loader/ods_loader'
require_relative 'spreadsheet_loader/xlsx_loader'

RgGen.setup_plugin :'rggen-spreadsheet-loader' do |plugin|
  plugin.version RgGen::SpreadsheetLoader::VERSION
  plugin.setup_loader :register_map, :spreadsheet do |entry|
    entry.register_loaders [
      RgGen::SpreadsheetLoader::CSVLoader,
      RgGen::SpreadsheetLoader::ODSLoader,
      RgGen::SpreadsheetLoader::XLSXLoader
    ]
  end
end
