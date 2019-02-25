require 'spec_helper'

module RgGen::SpreadsheetLoader
  describe SpreadsheetLoader do
    let(:loader) do
      Class.new(RgGen::Core::RegisterMap::Loader) do
        class << self
          attr_accessor :tables
        end

        include SpreadsheetLoader

        def read_spreadsheet(_file, book)
          self.class.tables.each do |sheet, table|
            book.add_sheet(sheet, table)
          end
        end
      end
    end

    let(:valid_value_lists) do
      [
        [],
        [:register_block_foo, :register_block_bar],
        [:register_foo, :register_bar],
        [:bit_field_foo, :bit_field_bar]
      ]
    end

    let(:input_data) do
      RgGen::Core::RegisterMap::InputData.new(:register_map, valid_value_lists)
    end

    describe '入力ファイルの読み込み' do
      let(:table_data_0) do
        [
          [nil, 'register_block_foo', 'register_block_foo_0'],
          [nil, 'register_block_bar', 'register_block_bar_0'],
          [],
          [nil, 'register_foo'    , 'register_bar'    , 'bit_field_foo'      , 'bit_field_bar'      ],
          [nil, 'register_foo_0_0', 'register_bar_0_0', 'bit_field_foo_0_0_0', 'bit_field_bar_0_0_0'],
          [nil, nil               , nil               , 'bit_field_foo_0_0_1', 'bit_field_bar_0_0_1'],
          [nil, 'register_foo_0_1', 'register_bar_0_1', 'bit_field_foo_0_1_0', 'bit_field_bar_0_1_0']
        ]
      end

      let(:table_data_1) do
        [
          [nil, 'register_block_foo', 'register_block_foo_1'],
          [nil, 'register_block_bar', 'register_block_bar_1'],
          [],
          [nil, 'register_foo'    , 'register_bar'    , 'bit_field_foo'      , 'bit_field_bar'      ],
          [nil, 'register_foo_1_0', 'register_bar_1_0', 'bit_field_foo_1_0_0', 'bit_field_bar_1_0_0'],
          [nil, nil               , nil               , nil                  , nil                  ],
          [nil, 'register_foo_1_1', 'register_bar_1_1', 'bit_field_foo_1_1_0', 'bit_field_bar_1_1_0'],
          [nil, nil               , nil               , 'bit_field_foo_1_1_1', 'bit_field_bar_1_1_1']
        ]
      end

      let(:file) { 'foo.xlsx' }

      let(:register_blocks) { input_data.children }

      let(:registers) { register_blocks.flat_map(&:children) }

      let(:bit_fields) { registers.flat_map(&:children) }

      def cell_position(sheet, row, column)
        Spreadsheet::Position.new(file, sheet, row, column)
      end

      before do
        allow(File).to receive(:readable?).with(file).and_return(true)
      end

      it '読み込んだスプレッドシートから入力データを組み立てる' do
        loader.tables = { 'sheet_0' => table_data_0, 'sheet_1' => table_data_1 }
        loader.load_file(file, input_data, valid_value_lists)

        expect(register_blocks[0])
          .to have_value(:register_block_foo, 'register_block_foo_0', cell_position('sheet_0', 0, 2))
          .and have_value(:register_block_bar, 'register_block_bar_0', cell_position('sheet_0', 1, 2))

        expect(register_blocks[1])
          .to have_value(:register_block_foo, 'register_block_foo_1', cell_position('sheet_1', 0, 2))
          .and have_value(:register_block_bar, 'register_block_bar_1', cell_position('sheet_1', 1, 2))

        expect(registers[0])
          .to have_value(:register_foo, 'register_foo_0_0', cell_position('sheet_0', 4, 1))
          .and have_value(:register_bar, 'register_bar_0_0', cell_position('sheet_0', 4, 2))
        expect(registers[1])
          .to have_value(:register_foo, 'register_foo_0_1', cell_position('sheet_0', 6, 1))
          .and have_value(:register_bar, 'register_bar_0_1', cell_position('sheet_0', 6, 2))
        expect(registers[2])
          .to have_value(:register_foo, 'register_foo_1_0', cell_position('sheet_1', 4, 1))
          .and have_value(:register_bar, 'register_bar_1_0', cell_position('sheet_1', 4, 2))
        expect(registers[3])
          .to have_value(:register_foo, 'register_foo_1_1', cell_position('sheet_1', 6, 1))
          .and have_value(:register_bar, 'register_bar_1_1', cell_position('sheet_1', 6, 2))

        expect(bit_fields[0])
          .to have_value(:bit_field_foo, 'bit_field_foo_0_0_0', cell_position('sheet_0', 4, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_0_0_0', cell_position('sheet_0', 4, 4))
        expect(bit_fields[1])
          .to have_value(:bit_field_foo, 'bit_field_foo_0_0_1', cell_position('sheet_0', 5, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_0_0_1', cell_position('sheet_0', 5, 4))
        expect(bit_fields[2])
          .to have_value(:bit_field_foo, 'bit_field_foo_0_1_0', cell_position('sheet_0', 6, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_0_1_0', cell_position('sheet_0', 6, 4))
        expect(bit_fields[3])
          .to have_value(:bit_field_foo, 'bit_field_foo_1_0_0', cell_position('sheet_1', 4, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_1_0_0', cell_position('sheet_1', 4, 4))
        expect(bit_fields[4])
          .to have_value(:bit_field_foo, 'bit_field_foo_1_1_0', cell_position('sheet_1', 6, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_1_1_0', cell_position('sheet_1', 6, 4))
        expect(bit_fields[5])
          .to have_value(:bit_field_foo, 'bit_field_foo_1_1_1', cell_position('sheet_1', 7, 3))
          .and have_value(:bit_field_bar, 'bit_field_bar_1_1_1', cell_position('sheet_1', 7, 4))
      end
    end
  end
end
