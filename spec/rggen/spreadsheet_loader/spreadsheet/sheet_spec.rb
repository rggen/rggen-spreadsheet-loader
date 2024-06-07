# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader::Spreadsheet::Sheet do
  let(:sheet) { described_class.new(book, sheet_name) }

  let(:file) { 'foo.xlsx' }

  let(:book) { double('book', file: file) }

  let(:sheet_name) { 'a sheet' }

  let(:table) do
    Array.new(3) do |row|
      Array.new(3) { |column| cell_value(row, column) }
    end
  end

  let(:flat_table) do
    table.flat_map.with_index do |row, row_index|
      row.map.with_index do |value, column_index|
        [row_index, column_index, value]
      end
    end
  end

  def cell_value(row, column)
    [(3 * row + column), 'foo', :foo, nil].sample
  end

  def cell_position(row, column)
    match_cell_position(file, sheet_name, row, column)
  end

  describe '#from_table' do
    it '与えられたテーブルで初期化する' do
      sheet.from_table(table)
      flat_table.each do |row, column, value|
        if value.nil?
          expect(sheet[row, column]).to be_empty_cell(cell_position(row, column))
        else
          expect(sheet[row, column]).to match_value(table[row][column], cell_position(row, column))
        end
      end
    end
  end

  describe '#rows' do
    def match_cells(values, row_index)
      matchers = []
      values.each_with_index do |value, column_index|
        matchers <<
          if value.nil?
            be_empty_cell(cell_position(row_index, column_index))
          else
            match_value(value, cell_position(row_index, column_index))
          end
      end
      match(matchers)
    end

    before { sheet.from_table(table) }

    context '無引数の場合' do
      it '表中の行を返す' do
        rows = sheet.rows
        rows.each_with_index do |row, row_index|
          expect(row.cells).to match_cells(table[row_index], row_index)
        end
      end
    end

    context '開始行が指定された場合' do
      let(:from) { [0, 1, 2].sample }

      let(:length) { 3 - from }

      it '指定された開始行からの行を返す' do
        rows = sheet.rows(from)
        expect(rows.size).to eq length
        rows.each.with_index(from) do |row, row_index|
          expect(row.cells).to match_cells(table[row_index], row_index)
        end
      end
    end

    context '開始行と長さが指定された場合' do
      let(:from) { [0, 1, 2].sample }

      let(:length) { (1..(3 - from)).to_a.sample }

      it '指定された行から、長さ分行を返す' do
        rows = sheet.rows(from, length)
        expect(rows.size).to eq length
        rows.each.with_index(from) do |row, row_index|
          expect(row.cells).to match_cells(table[row_index], row_index)
        end
      end
    end
  end
end
