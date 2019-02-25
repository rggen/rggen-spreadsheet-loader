
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.include?(lib) || $LOAD_PATH.unshift(lib)
require 'rggen/spreadsheet_loader/version'

Gem::Specification.new do |spec|
  spec.name = 'rggen-spreadsheet-loader'
  spec.version = RgGen::SpreadsheetLoader::VERSION
  spec.authors = ['Taichi Ishitani']
  spec.email = ['taichi730@gmail.com']

  spec.summary = "rggen-spreadsheet-loader-#{RgGen::SpreadsheetLoader::VERSION}"
  spec.description = 'Spreadsheet loader for RgGen register map.'
  spec.homepage = 'https://github.com/rggen/rggen-spreadsheet-loader'
  spec.license = 'MIT'

  spec.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_runtime_dependency 'roo', '>= 2.8'
  spec.add_runtime_dependency 'roo-xls', '>= 1.2'

  spec.add_development_dependency 'bundler'
end
