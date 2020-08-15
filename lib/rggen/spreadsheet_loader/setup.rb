# frozen_string_literal: true

require 'rggen/spreadsheet_loader'
RgGen.setup RgGen::SpreadsheetLoader do |builder|
  builder.ignore_value :register_map, :spreadsheet, :register_block, :comment
  builder.ignore_value :register_map, :spreadsheet, :register, :comment
end
