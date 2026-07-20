require 'spec_helper'

describe ThatLanguage::Client::VersionQuery do
  subject(:query) { described_class.new }

  setup_stubbed_requests

  it_behaves_like "a query targeting", "/version"
  its(:version) { is_expected.to eq("42") }
end
