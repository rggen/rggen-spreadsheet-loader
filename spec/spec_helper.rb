if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'lib/rggen/core/spec_helpers'
    add_filter 'spec/support/custom_matchers/'
  end

  if ENV['CODECOV_TOKEN']
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  end
end

require 'bundler/setup'
require 'rggen/core'

builder = RgGen::Core::Builder.create
RgGen.builder(builder)

require 'rggen/spreadsheet_loader'
require 'rggen/core/spec_helpers'
require 'support/custom_matchers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
