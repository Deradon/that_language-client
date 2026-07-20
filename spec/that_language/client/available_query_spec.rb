require 'spec_helper'

describe ThatLanguage::Client::AvailableQuery do
  subject(:query) { described_class.new }

  setup_stubbed_requests

  # endpoint is private; rspec-its 2.0 resolves the subject with public_send.
  it "targets /available" do
    expect(query.send(:endpoint)).to eq("/available")
  end

  # Symbol keys and symbol values, matching the core gem's `{ak: :Akan}`.
  # JSON gives strings for both, so the conversion is the client's job.
  its(:available) {
    is_expected.to eq({
      de: :German,
      en: :English
    })
  }
end
