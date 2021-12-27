# frozen_string_literal: true

require File.expand_path('lib/rggen/spreadsheet_loader/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'rggen-spreadsheet-loader'
  spec.version = RgGen::SpreadsheetLoader::VERSION
  spec.authors = ['Taichi Ishitani']
  spec.email = ['rggen@googlegroups.com']

  spec.summary = "rggen-spreadsheet-loader-#{RgGen::SpreadsheetLoader::VERSION}"
  spec.description = 'Spreadsheet loader for RgGen register map.'
  spec.homepage = 'https://github.com/rggen/rggen-spreadsheet-loader'
  spec.license = 'MIT'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/rggen/rggen-spreadsheet-loader/issues',
    'mailing_list_uri' => 'https://groups.google.com/d/forum/rggen',
    'source_code_uri' => 'https://github.com/rggen/rggen-spreadsheet-loader',
    'wiki_uri' => 'https://github.com/rggen/rggen/wiki'
  }

  spec.files = `git ls-files lib LICENSE CODE_OF_CONDUCT.md README.md`.split($RS)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_runtime_dependency 'roo', '>= 2.8'
  spec.add_runtime_dependency 'simple_xlsx_reader', '>= 1.0.4'
  spec.add_runtime_dependency 'spreadsheet', '>= 1.2.5'
  spec.add_runtime_dependency 'spreadbase', '>= 0.3.0'

  spec.add_development_dependency 'bundler'
end
