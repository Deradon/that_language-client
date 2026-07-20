require 'spec_helper'

describe ThatLanguage::Client::VersionQuery do
  subject(:query) { described_class.new }

  setup_stubbed_requests

  # endpoint is private; rspec-its 2.0 resolves the subject with public_send.
  it "targets /version" do
    expect(query.send(:endpoint)).to eq("/version")
  end
  its(:version) { is_expected.to eq("42") }
end
