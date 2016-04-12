require 'spec_helper'

describe ThatLanguage::Client::VersionQuery do
  subject(:query) { described_class.new }

  setup_stubbed_requests

  its(:endpoint) { is_expected.to eq("/version") }
  its(:version) { is_expected.to eq("42") }
end
