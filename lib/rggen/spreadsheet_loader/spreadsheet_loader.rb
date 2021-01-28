# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    module SpreadsheetLoader
      Position = Struct.new(:row, :column)

      def read_file(file)
        Spreadsheet::Book.new(file) { |book| read_spreadsheet(file, book) }
      end

      private

      def format_layer_data(read_data, layer, _file)
        return if layer == :root
        collect_layer_data(read_data, layer)
      end

      def collect_layer_data(read_data, layer)
        values = valid_values(layer)
        cells = __send__("#{layer}_cells", read_data)
        values.zip(cells).to_h
      end

      def register_block_cells(sheet)
        start_row = register_block_start_position.row
        start_column = register_block_start_position.column
        Array.new(valid_values(:register_block).size) do |i|
          sheet[start_row + i, start_column]
        end
      end

      def register_cells(rows)
        start_column = register_start_position.column
        size = valid_values(:register).size
        rows.first.cells(start_column, size)
      end

      def bit_field_cells(row)
        start_column = bit_field_start_position.column
        size = valid_values(:bit_field).size
        row.cells(start_column, size)
      end

      SUB_LAYERS = {
        root: :register_block,
        register_block: :register,
        register: :bit_field
      }.freeze

      def format_sub_layer_data(read_data, layer, _file)
        sub_layer = SUB_LAYERS[layer]
        sub_layer && { sub_layer => __send__("collect_#{sub_layer}_data", read_data) }
      end

      def collect_register_block_data(book)
        book.sheets
      end

      def collect_register_data(sheet)
        sheet
          .rows(register_start_position.row)
          .reject { |row| row.cells.all?(&:empty_cell?) }
          .each_with_object([], &method(:collect_register_rows))
      end

      def collect_register_rows(row, row_sets)
        register_begin?(row) && (row_sets << [])
        row_sets.last << row
      end

      def register_begin?(row)
        !row[register_start_position.column].empty_cell?
      end

      def collect_bit_field_data(rows)
        rows
      end

      def register_block_start_position
        @register_block_start_position ||= Position.new(0, 2)
      end

      def register_start_position
        @register_start_position ||=
          Position.new(valid_values(:register_block).size + 2, 1)
      end

      def bit_field_start_position
        @bit_field_start_position ||=
          Position.new(0, bit_field_start_column)
      end

      def bit_field_start_column
        register_start_position.column + valid_values(:register).size
      end
    end
  end
end
