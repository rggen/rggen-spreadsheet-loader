# frozen_string_literal: true

require 'roo'
require 'roo-xls'
require_relative 'spreadsheet_loader/version'
require_relative 'spreadsheet_loader/spreadsheet/position'
require_relative 'spreadsheet_loader/spreadsheet/cell'
require_relative 'spreadsheet_loader/spreadsheet/row'
require_relative 'spreadsheet_loader/spreadsheet/sheet'
require_relative 'spreadsheet_loader/spreadsheet/book'
require_relative 'spreadsheet_loader/spreadsheet_loader'
require_relative 'spreadsheet_loader/roo_loader'

module RgGen
  module SpreadsheetLoader
    def self.setup(builder)
      builder.register_loader(:register_map, RooLoader)
    end
  end

  setup :'spreadsheet-loader', SpreadsheetLoader
end
