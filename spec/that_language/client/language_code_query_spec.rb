require 'spec_helper'

describe ThatLanguage::Client::LanguageCodeQuery do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { ThatLanguage::Client.new(host: "foo.bar") }

  its(:client) { is_expected.to eq(client) }
  its(:url) { is_expected.to eq("http://foo.bar/language_code") }

  describe "#language_code" do
    subject { query.language_code }

    before do
      stub_request(:post, "http://foo.bar/language_code")
        .with(body: { "text" => "Just an example" })
        .to_return(body: '{"language_code":"en"}')
    end

    it { is_expected.to eq("en") }
  end
end
