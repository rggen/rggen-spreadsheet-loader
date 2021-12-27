# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader do
  describe '既定セットアップ' do
    let(:builder) { RgGen.builder }

    before do
      @original_builder = RgGen.builder
      RgGen.builder(RgGen::Core::Builder.create)
    end

    after do
      RgGen.builder(@original_builder)
    end

    it 'builderにCSVLoader/RooLoader/XLSLoaderを登録する' do
      expect(builder).to receive(:register_loader).with(:register_map, :spreadsheet, equal(RgGen::SpreadsheetLoader::CSVLoader)).and_call_original
      expect(builder).to receive(:register_loader).with(:register_map, :spreadsheet, equal(RgGen::SpreadsheetLoader::ODSLoader)).and_call_original
      expect(builder).to receive(:register_loader).with(:register_map, :spreadsheet, equal(RgGen::SpreadsheetLoader::RooLoader)).and_call_original
      expect(builder).to receive(:register_loader).with(:register_map, :spreadsheet, equal(RgGen::SpreadsheetLoader::XLSLoader)).and_call_original
      expect(builder).to receive(:ignore_value).with(:register_map, :spreadsheet, :register_block, :comment).and_call_original
      expect(builder).to receive(:ignore_value).with(:register_map, :spreadsheet, :register, :comment).and_call_original
      builder.load_plugins(['rggen/spreadsheet_loader/setup'], true)
    end
  end
end
