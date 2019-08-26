# frozen_string_literal: true

require 'spec_helper'

module RgGen
  describe SpreadsheetLoader do
    describe '既定セットアップ' do
      let(:builder) { RgGen.builder }

      it 'builderにRooLoaderを登録する' do
        expect(builder).to receive(:register_loader).with(:register_map, equal(RgGen::SpreadsheetLoader::RooLoader))
        require 'rggen/spreadsheet_loader/setup'
      end
    end
  end
end
