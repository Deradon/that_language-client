require 'spec_helper'

describe ThatLanguage::Client::DetectQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  # endpoint is private; rspec-its 2.0 resolves the subject with public_send.
  it "targets /detect" do
    expect(query.send(:endpoint)).to eq("/detect")
  end
  its(:language) { is_expected.to eq(:English) }
  its(:language_code) { is_expected.to eq("en") }
  its(:confidence) { is_expected.to eq(0.8) }
end
