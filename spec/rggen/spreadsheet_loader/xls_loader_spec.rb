# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RgGen::SpreadsheetLoader::XLSLoader do
  let(:loader) { RgGen::SpreadsheetLoader::XLSLoader }

  let(:valid_value_lists) do
    [
      [],
      [:register_block_foo, :register_block_bar],
      [:register_foo, :register_bar],
      [:bit_field_foo, :bit_field_bar]
    ]
  end

  let(:input_data) do
    RgGen::Core::RegisterMap::RegisterMapData.new(valid_value_lists)
  end

  let(:register_blocks) { input_data.children }

  let(:registers) { register_blocks.flat_map(&:children) }

  let(:bit_fields) { registers.flat_map(&:children) }

  def match_with_sheet_0(file, sheet)
    expect(register_blocks[0])
      .to have_value(:register_block_foo, 'register_block_foo_0', cell_position(file, sheet, 0, 2))
      .and have_value(:register_block_bar, 'register_block_bar_0', cell_position(file, sheet, 1, 2))

    expect(registers[0])
      .to have_value(:register_foo, 'register_foo_0_0', cell_position(file, sheet, 4, 1))
      .and have_value(:register_bar, 'register_bar_0_0', cell_position(file, sheet, 4, 2))
    expect(registers[1])
      .to have_value(:register_foo, 'register_foo_0_1', cell_position(file, sheet, 6, 1))
      .and have_value(:register_bar, 'register_bar_0_1', cell_position(file, sheet, 6, 2))

    expect(bit_fields[0])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_0_0', cell_position(file, sheet, 4, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_0_0', cell_position(file, sheet, 4, 4))
    expect(bit_fields[1])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_0_1', cell_position(file, sheet, 5, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_0_1', cell_position(file, sheet, 5, 4))
    expect(bit_fields[2])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_1_0', cell_position(file, sheet, 6, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_1_0', cell_position(file, sheet, 6, 4))
  end

  def match_with_sheet_1(file, sheet)
    expect(register_blocks[1])
      .to have_value(:register_block_foo, 'register_block_foo_1', cell_position(file, sheet, 0, 2))
      .and have_value(:register_block_bar, 'register_block_bar_1', cell_position(file, sheet, 1, 2))

    expect(registers[2])
      .to have_value(:register_foo, 'register_foo_1_0', cell_position(file, sheet, 4, 1))
      .and have_value(:register_bar, 'register_bar_1_0', cell_position(file, sheet, 4, 2))
    expect(registers[3])
      .to have_value(:register_foo, 'register_foo_1_1', cell_position(file, sheet, 5, 1))
      .and have_value(:register_bar, 'register_bar_1_1', cell_position(file, sheet, 5, 2))

    expect(bit_fields[3])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_0_0', cell_position(file, sheet, 4, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_0_0', cell_position(file, sheet, 4, 4))
    expect(bit_fields[4])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_1_0', cell_position(file, sheet, 5, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_1_0', cell_position(file, sheet, 5, 4))
    expect(bit_fields[5])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_1_1', cell_position(file, sheet, 6, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_1_1', cell_position(file, sheet, 6, 4))
  end

  def cell_position(file, sheet, row, column)
    RgGen::SpreadsheetLoader::Spreadsheet::Position.new(file, sheet, row, column)
  end

  it 'xls形式に対応する' do
    expect(loader.support?('foo.xls')).to be true
    expect(loader.support?('foo.xlsx')).to be false
    expect(loader.support?('foo.ods')).to be false
    expect(loader.support?('foo.csv')).to be false
    random_file_extensions(max_length: 4, exceptions: ['xls']).each do |extension|
      expect(loader.support?("foo.#{extension}")).to be false
    end
  end

  it 'xls形式のスプレッドシートをロードできる' do
    file = File.expand_path('../../files/test.xls', __dir__)
    loader.load_file(file, input_data, valid_value_lists)
    match_with_sheet_0(file, 'sheet_0')
    match_with_sheet_1(file, 'sheet_1')
  end
end
