require 'spec_helper'

describe ThatLanguage::Client::LanguageCodeQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  it_behaves_like "a query targeting", "/language_code"
  its(:language_code) { is_expected.to eq("en") }
end
