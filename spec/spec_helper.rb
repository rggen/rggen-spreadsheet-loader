# frozen_string_literal: true

require 'bundler/setup'
require 'rggen/devtools/spec_helper'
require 'support/custom_matchers'

RSpec.configure do |config|
  RgGen::Devtools::SpecHelper.setup(config)
end

require 'rggen/core'

builder = RgGen::Core::Builder.create
RgGen.builder(builder)

require 'rggen/spreadsheet_loader'
