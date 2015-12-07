require 'spec_helper'

describe ThatLanguage::Client::LanguageQuery do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { ThatLanguage::Client.new(host: "foo.bar") }

  its(:client) { is_expected.to eq(client) }
  its(:url) { is_expected.to eq("http://foo.bar/language") }

  describe "#language" do
    subject { query.language }

    before do
      stub_request(:post, "http://foo.bar/language")
        .with(body: { "text" => "Just an example" })
        .to_return(body: '{"language":"English"}')
    end

    it { is_expected.to eq("English") }
  end
end
