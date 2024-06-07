# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader::Spreadsheet::Row do
  let(:row) { described_class.new(sheet, row_index) }

  let(:file) { 'foo.xlsx' }

  let(:sheet_name) { 'a sheet' }

  let(:sheet) do
    double('sheet', file: file, sheet: sheet_name)
  end

  let(:row_index) { (0..10).to_a.sample }

  def cell_position(column_index)
    match_cell_position(file, sheet_name, row_index, column_index)
  end

  describe '#[]=' do
    let(:values) { [1, 'foo', :foo, nil].shuffle }

    let(:column_indexes) { (0..10).to_a.sample(4) }

    it '指定したカラムに、セルを追加する' do
      row[column_indexes[0]] = values[0]
      row[column_indexes[1]] = values[1]
      row[column_indexes[2]] = values[2]

      expect(row[column_indexes[0]]).to match_value(values[0], cell_position(column_indexes[0]))
      expect(row[column_indexes[1]]).to match_value(values[1], cell_position(column_indexes[1]))
      expect(row[column_indexes[2]]).to match_value(values[2], cell_position(column_indexes[2]))
    end
  end

  describe '#[]' do
    context '値が設定されていないカラムを参照した場合' do
      let(:column_index) { (0..10).to_a.sample }

      it '空のセルを返す' do
        expect(row[column_index]).to be_empty_cell(cell_position(column_index))
      end
    end
  end

  describe '#cells' do
    let(:filled_columns) do
      (0..9).to_a.sample(2).push(10)
    end

    let(:values) do
      filled_columns
        .map { |column| [column, rand(99)] }
        .to_h
    end

    before do
      values.each { |column, value| row[column] = value }
    end

    context '無引数の場合' do
      it '行中のセルを返す' do
        cells = row.cells
        expect(cells.size).to eq 11
        cells.each_with_index do |cell, column|
          if filled_columns.include?(column)
            expect(cell).to match_value(values[column], cell_position(column))
          else
            expect(cell).to be_empty_cell(cell_position(column))
          end
        end
      end
    end

    context '開始点が指定された場合' do
      let(:from) { (0..10).to_a.sample }

      let(:length) { 11 - from }

      it '指定された開始点からのセルを返す' do
        cells = row.cells(from)
        expect(cells.size).to eq length
        cells.each.with_index(from) do |cell, column|
          if filled_columns.include?(column)
            expect(cell).to match_value(values[column], cell_position(column))
          else
            expect(cell).to be_empty_cell(cell_position(column))
          end
        end
      end
    end

    context '開始点と長さが指定された場合' do
      let(:from) { (0..10).to_a.sample }

      let(:length) { (1..(11 - from)).to_a.sample }

      it '指定された開始点からのセルを、指定された長さ分返す' do
        cells = row.cells(from, length)
        expect(cells.size).to eq length
        cells.each.with_index(from) do |cell, column|
          if filled_columns.include?(column)
            expect(cell).to match_value(values[column], cell_position(column))
          else
            expect(cell).to be_empty_cell(cell_position(column))
          end
        end
      end
    end
  end
end
