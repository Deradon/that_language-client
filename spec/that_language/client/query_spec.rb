require 'spec_helper'

describe ThatLanguage::Client::Query do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { ThatLanguage::Client.new(host: "foo.bar") }

  context "when given a client" do
    let(:expected_client) { client }

    it_behaves_like "a query using client", "the client it was given"
  end

  context "when initialized without a client" do
    subject(:query) { described_class.new(text: text) }
    let(:expected_client) { ThatLanguage::Client.current }

    it_behaves_like "a query using client", "the current client"
  end
end
