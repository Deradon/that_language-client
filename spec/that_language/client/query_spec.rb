require 'spec_helper'

describe ThatLanguage::Client::Query do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { ThatLanguage::Client.new(host: "foo.bar") }

  # client is a private reader; rspec-its 2.0 resolves the subject with
  # public_send, so it is reached explicitly here.
  it "keeps the client it was given" do
    expect(query.send(:client)).to eq(client)
  end

  context "when initialized without a client" do
    subject(:query) { described_class.new(text: text) }

    it "falls back to the current client" do
      expect(query.send(:client)).to eq(ThatLanguage::Client.current)
    end
  end
end
