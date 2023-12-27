# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rggen-spreadsheet-loader.gemspec
gemspec

root = ENV['RGGEN_ROOT'] || File.expand_path('..', __dir__)
gemfile = File.join(root, 'rggen-devtools', 'gemfile', 'common.gemfile')
eval_gemfile(gemfile)

group :rggen do
  gem_patched 'facets'
  gem_patched 'rubyzip'
end

if ENV.key?('CI')
  if ENV['GITHUB_WORKFLOW'] == 'CI'
    require File.join(root, 'stdgems-version/lib/stdgems_version')
    gem 'bigdecimal', StdgemsVersion.version('bigdecimal')
    gem 'csv', StdgemsVersion.version('csv')
  else
    # Workaround for 64kramsystem/spreadbase#30
    # https://github.com/64kramsystem/spreadbase/issues/30
    gem 'bigdecimal'
  end
end
