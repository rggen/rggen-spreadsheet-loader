# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader do
  describe '既定セットアップ' do
    let(:builder) { RgGen.builder }

    it 'builderにCSVLoader/RooLoader/XLSLoaderを登録する' do
      expect(builder).to receive(:register_loader).with(:register_map, equal(RgGen::SpreadsheetLoader::CSVLoader))
      expect(builder).to receive(:register_loader).with(:register_map, equal(RgGen::SpreadsheetLoader::RooLoader))
      expect(builder).to receive(:register_loader).with(:register_map, equal(RgGen::SpreadsheetLoader::XLSLoader))
      require 'rggen/spreadsheet_loader/setup'
      builder.activate_plugins
    end
  end
end
