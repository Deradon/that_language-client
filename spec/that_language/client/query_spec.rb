require 'spec_helper'

describe ThatLanguage::Client::Query do
  subject(:query) { described_class.new(text: text, client: client) }
  let(:text) { "Just an example" }
  let(:client) { ThatLanguage::Client.new(host: "foo.bar") }

  its(:client) { is_expected.to eq(client) }

  context "when initialized without a client" do
    subject { described_class.new(text: text) }
    its(:client) { is_expected.to eq(ThatLanguage::Client.current) }
  end
end
