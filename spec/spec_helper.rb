$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/its'
require 'webmock/rspec'
require 'support/that_language_client_spec_helper'
require 'that_language/client'

RSpec.configure do |config|
  config.order = 'random'

  config.include ThatLanguageClientSpecHelper
end
