require 'spec_helper'

describe DetectLanguage::Client::LocaleQuery do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { DetectLanguage::Client.new(host: "foo.bar") }

  its(:client) { is_expected.to eq(client) }
  its(:url) { is_expected.to eq("http://foo.bar/locale") }

  describe "#locale" do
    subject { query.locale }

    before do
      stub_request(:post, "http://foo.bar/locale")
        .with(body: { "text" => "Just an example" })
        .to_return(body: '{"locale":"en","value":0.3,"score":0.2,"percentage":0.28,"hit_ratio":0.8,"hit_count":4,"words_count":5}')
    end

    it { is_expected.to eq("en") }
  end

  context "when initialized without a client" do
    subject { described_class.new(text: text) }
    its(:client) { is_expected.to eq(DetectLanguage::Client.current) }
  end
end
