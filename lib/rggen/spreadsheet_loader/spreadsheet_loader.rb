# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module SpreadsheetLoader
      Position = Struct.new(:row, :column)

      def read_file(file)
        Spreadsheet::Book.new(file) { |book| read_spreadsheet(file, book) }
      end

      def format(book, _file)
        book.sheets.each(&method(:process_sheet))
      end

      private

      def process_sheet(sheet)
        register_block = parse_register_block(sheet)
        sheet
          .rows(register_start_position.row)
          .reject { |row| row.cells.all?(&:empty_cell?) }
          .each { |row| process_row(row, register_block) }
      end

      def parse_register_block(sheet)
        register_map.register_block do
          register_block_valid_values
            .zip(register_block_cells(sheet))
            .each { |value_name, cell| value(value_name, cell) }
        end
      end

      def register_block_cells(sheet)
        start_row = register_block_start_position.row
        start_column = register_block_start_position.column
        Array.new(register_block_valid_values.size) do |i|
          sheet[start_row + i, start_column]
        end
      end

      def process_row(row, register_block)
        register =
          if row[register_start_position.column].empty_cell?
            register_block.children.last
          else
            parse_register(row, register_block)
          end
        parse_bit_field(row, register)
      end

      def parse_register(row, register_block)
        register_block.register do
          register_valid_values
            .zip(register_cells(row))
            .each { |value_name, cell| value(value_name, cell) }
        end
      end

      def register_cells(row)
        start_column = register_start_position.column
        size = register_valid_values.size
        row.cells(start_column, size)
      end

      def parse_bit_field(row, register)
        register.bit_field do
          bit_field_valid_values
            .zip(bit_field_cells(row))
            .each { |value_name, cell| value(value_name, cell) }
        end
      end

      def bit_field_cells(row)
        start_column = bit_field_start_position.column
        size = bit_field_valid_values.size
        row.cells(start_column, size)
      end

      def register_block_start_position
        @register_block_start_position ||= Position.new(0, 2)
      end

      def register_start_position
        @register_start_position ||=
          Position.new(register_block_valid_values.size + 2, 1)
      end

      def bit_field_start_position
        @bit_field_start_position ||=
          begin
            column =
              register_start_position.column + register_valid_values.size
            Position.new(0, column)
          end
      end

      def register_block_valid_values
        valid_value_lists[1]
      end

      def register_valid_values
        valid_value_lists[2]
      end

      def bit_field_valid_values
        valid_value_lists[3]
      end
    end
  end
end
