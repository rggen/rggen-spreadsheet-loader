# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader::SpreadsheetLoader do
  include_context 'loader common'

  let(:loader) do
    Class.new(RgGen::Core::RegisterMap::Loader) do
      class << self
        attr_accessor :tables
      end

      include RgGen::SpreadsheetLoader::SpreadsheetLoader

      def read_spreadsheet(_file, book)
        self.class.tables.each do |sheet, table|
          book.add_sheet(sheet, table)
        end
      end
    end
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

    before do
      allow(File).to receive(:readable?).with(file).and_return(true)
    end

    it '読み込んだスプレッドシートから入力データを組み立てる' do
      loader.tables = { 'sheet_0' => table_data_0, 'sheet_1' => table_data_1 }
      loader.load_file(file, input_data, valid_value_lists)
      match_with_sheet_0(file, 'sheet_0')
      match_with_sheet_1(file, 'sheet_1')
    end
  end
end
