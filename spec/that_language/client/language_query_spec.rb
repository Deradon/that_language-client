require 'spec_helper'

describe ThatLanguage::Client::LanguageQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  # endpoint is private; rspec-its 2.0 resolves the subject with public_send.
  it "targets /language" do
    expect(query.send(:endpoint)).to eq("/language")
  end
  its(:language) { is_expected.to eq(:English) }
end
