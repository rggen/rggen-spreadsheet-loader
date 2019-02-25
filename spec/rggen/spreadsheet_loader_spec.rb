require 'spec_helper'

module RgGen
  describe SpreadsheetLoader do
    describe '.setup' do
      let(:builder) do
        builder = RgGen::Core::Builder::Builder.new
        builder.register_input_components
        builder
      end

      it 'builderにRooLoaderを登録する' do
        allow(builder).to receive(:register_loader).and_call_original
        SpreadsheetLoader.setup(builder)
        expect(builder).to have_received(:register_loader).with(:register_map, equal(RgGen::SpreadsheetLoader::RooLoader))
      end
    end
  end
end
