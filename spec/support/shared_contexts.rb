# frozen_string_literal: true

RSpec.shared_context 'loader common' do
  let(:valid_value_lists) do
    {
      root: [],
      register_block: [:register_block_foo, :register_block_bar],
      register_file: [],
      register: [:register_foo, :register_bar],
      bit_field: [:bit_field_foo, :bit_field_bar]
    }
  end

  let(:input_data) do
    RgGen::Core::RegisterMap::InputData.new(:root, valid_value_lists, nil)
  end

  let(:register_blocks) do
    input_data.children
  end

  let(:registers) do
    register_blocks.flat_map(&:children)
  end

  let(:bit_fields) do
    registers.flat_map(&:children)
  end

  def match_with_sheet_0(file, sheet)
    expect(register_blocks[0])
      .to have_value(:register_block_foo, 'register_block_foo_0', match_cell_position(file, sheet, 0, 2))
      .and have_value(:register_block_bar, 'register_block_bar_0', match_cell_position(file, sheet, 1, 2))

    expect(registers[0])
      .to have_value(:register_foo, 'register_foo_0_0', match_cell_position(file, sheet, 4, 1))
      .and have_value(:register_bar, 'register_bar_0_0', match_cell_position(file, sheet, 4, 2))
    expect(registers[1])
      .to have_value(:register_foo, 'register_foo_0_1', match_cell_position(file, sheet, 6, 1))
      .and have_value(:register_bar, 'register_bar_0_1', match_cell_position(file, sheet, 6, 2))

    expect(bit_fields[0])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_0_0', match_cell_position(file, sheet, 4, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_0_0', match_cell_position(file, sheet, 4, 4))
    expect(bit_fields[1])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_0_1', match_cell_position(file, sheet, 5, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_0_1', match_cell_position(file, sheet, 5, 4))
    expect(bit_fields[2])
      .to have_value(:bit_field_foo, 'bit_field_foo_0_1_0', match_cell_position(file, sheet, 6, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_0_1_0', match_cell_position(file, sheet, 6, 4))
  end

  def match_with_sheet_1(file, sheet)
    expect(register_blocks[1])
      .to have_value(:register_block_foo, 'register_block_foo_1', match_cell_position(file, sheet, 0, 2))
      .and have_value(:register_block_bar, 'register_block_bar_1', match_cell_position(file, sheet, 1, 2))

    expect(registers[2])
      .to have_value(:register_foo, 'register_foo_1_0', match_cell_position(file, sheet, 4, 1))
      .and have_value(:register_bar, 'register_bar_1_0', match_cell_position(file, sheet, 4, 2))
    expect(registers[3])
      .to have_value(:register_foo, 'register_foo_1_1', match_cell_position(file, sheet, 6, 1))
      .and have_value(:register_bar, 'register_bar_1_1', match_cell_position(file, sheet, 6, 2))

    expect(bit_fields[3])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_0_0', match_cell_position(file, sheet, 4, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_0_0', match_cell_position(file, sheet, 4, 4))
    expect(bit_fields[4])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_1_0', match_cell_position(file, sheet, 6, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_1_0', match_cell_position(file, sheet, 6, 4))
    expect(bit_fields[5])
      .to have_value(:bit_field_foo, 'bit_field_foo_1_1_1', match_cell_position(file, sheet, 7, 3))
      .and have_value(:bit_field_bar, 'bit_field_bar_1_1_1', match_cell_position(file, sheet, 7, 4))
  end
end
