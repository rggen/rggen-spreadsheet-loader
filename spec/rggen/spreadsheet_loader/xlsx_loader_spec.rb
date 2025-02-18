# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader::XLSXLoader do
  include_context 'loader common'

  let(:loader) { described_class.new([], {}) }

  it 'xlsx形式に対応する' do
    expect(loader.support?('foo.xlsx')).to be true
    expect(loader.support?('foo.csv')).to be false
    expect(loader.support?('foo.ods')).to be false
    expect(loader.support?('foo.xls')).to be false
    random_file_extensions(max_length: 4, exceptions: ['xlsx']).each do |extension|
      expect(loader.support?("foo.#{extension}")).to be false
    end
  end

  it 'xlsx形式のスプレッドシートをロードできる' do
    file = File.expand_path('../../files/test.xlsx', __dir__)
    loader.load_data(input_data, valid_value_lists, file)
    match_with_sheet_0(file, 'sheet_0')
    match_with_sheet_1(file, 'sheet_1')
  end
end
