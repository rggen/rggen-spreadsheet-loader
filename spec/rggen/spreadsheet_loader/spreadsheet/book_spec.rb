require 'spec_helper'

module RgGen::SpreadsheetLoader::Spreadsheet
  describe Book do
    let(:book) { Book.new(file) }

    let(:file) { 'foo.xlsx' }

    describe '#add_sheet' do
      let(:tables) do
        [create_table(3, 3), create_table(3, 4)]
      end

      def create_table(row_size, column_size)
        Array.new(row_size) do |row|
          Array.new(column_size) { |column| cell_value(row, column, column_size) }
        end
      end

      def cell_value(row, column, column_size)
        [(column_size * row + column), 'foo', :foo, nil].sample
      end

      def flat_table(table)
        table.flat_map.with_index do |row, row_index|
          row.map.with_index do |value, column_index|
            [row_index, column_index, value]
          end
        end
      end

      def match_cell(value, sheet, row, column)
        position = Position.new(file, sheet, row, column)
        if value.nil?
          be_empty_cell(position)
        else
          match_value(value, position)
        end
      end

      it '与えられたシート名、テーブルでシートを追加する' do
        book.add_sheet('sheet_0', tables[0])
        book.add_sheet('sheet_1', tables[1])

        sheet = book.sheets[0]
        expect(sheet).to have_attributes(file: file, sheet: 'sheet_0')
        flat_table(tables[0]).each do |row, column, value|
          expect(sheet[row, column]).to match_cell(value, 'sheet_0', row, column)
        end

        sheet = book.sheets[1]
        expect(sheet).to have_attributes(file: file, sheet: 'sheet_1')
        flat_table(tables[1]).each do |row, column, value|
          expect(sheet[row, column]).to match_cell(value, 'sheet_1', row, column)
        end
      end
    end
  end
end
