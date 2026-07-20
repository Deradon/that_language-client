require 'spec_helper'

describe ThatLanguage::Client::LanguageCodeQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  # endpoint is private; rspec-its 2.0 resolves the subject with public_send.
  it "targets /language_code" do
    expect(query.send(:endpoint)).to eq("/language_code")
  end
  its(:language_code) { is_expected.to eq("en") }
end
