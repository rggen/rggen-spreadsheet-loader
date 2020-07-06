# frozen_string_literal: true

require 'bundler/setup'
require 'rggen/devtools/spec_helper'
require 'support/custom_matchers'
require 'support/shared_contexts'

require 'rggen/core'

builder = RgGen::Core::Builder.create
RgGen.builder(builder)

RSpec.configure do |config|
  RgGen::Devtools::SpecHelper.setup(config)
end

require 'rggen/spreadsheet_loader'
