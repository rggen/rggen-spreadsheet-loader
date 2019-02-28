# frozen_string_literal: true

module RgGen
  module SpreadsheetLoader
    def self.setup(builder)
      builder.register_loader(:register_map, RooLoader)
    end
  end

  RgGen.setup do |builder|
    SpreadsheetLoader.setup(builder)
  end
end
