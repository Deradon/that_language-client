require 'spec_helper'

describe ThatLanguage::Client::DetectQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  it_behaves_like "a query targeting", "/detect"
  its(:language) { is_expected.to eq(:English) }
  its(:language_code) { is_expected.to eq("en") }
  its(:confidence) { is_expected.to eq(0.8) }
end
