# frozen_string_literal: true

RSpec.describe RgGen::SpreadsheetLoader::CSVLoader do
  include_context 'loader common'

  let(:loader) { described_class.new([], {}) }

  it 'csv形式に対応する' do
    expect(loader.support?('foo.csv')).to be true
    expect(loader.support?('foo.xlsx')).to be false
    expect(loader.support?('foo.xls')).to be false
    expect(loader.support?('foo.ods')).to be false
    random_file_extensions(max_length: 4, exceptions: ['csv', 'tsv']).each do |extension|
      expect(loader.support?("foo.#{extension}")).to be false
    end
  end

  it 'csv形式のスプレッドシートをロードできる' do
    file = File.expand_path('../../files/test.csv', __dir__)
    loader.load_data(input_data, valid_value_lists, file)
    match_with_sheet_0(file, 'test')
  end

  it 'tsv形式に対応する' do
    expect(loader.support?('foo.tsv')).to be true
    expect(loader.support?('foo.xlsx')).to be false
    expect(loader.support?('foo.xls')).to be false
    expect(loader.support?('foo.ods')).to be false
    random_file_extensions(max_length: 4, exceptions: ['csv', 'tsv']).each do |extension|
      expect(loader.support?("foo.#{extension}")).to be false
    end
  end

  it 'tsv形式のスプレッドシートをロードできる' do
    file = File.expand_path('../../files/test.tsv', __dir__)
    loader.load_data(input_data, valid_value_lists, file)
    match_with_sheet_0(file, 'test')
  end
end
