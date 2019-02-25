module RgGen
  module SpreadsheetLoader
    roo_table_formatter = Module.new do
      def to_table(sheet = default_sheet, **options)
        from_row = options[:from_row] || first_row(sheet)
        to_row = options[:to_row] || last_row(sheet)
        from_column = options[:from_column] || first_column(sheet)
        to_column = options[:to_column] || last_column(sheet)
        (from_row..to_row).map do |row|
          (from_column..to_column).map { |column| cell(row, column, sheet) }
        end
      end
    end

    ::Roo::Base.class_eval { include roo_table_formatter }
  end
end
