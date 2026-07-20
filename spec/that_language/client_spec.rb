require 'spec_helper'

describe ThatLanguage::Client do
  subject { described_class.new(host: "foo.bar") }

  its(:host) { is_expected.to eq("foo.bar") }

  it 'has a version number' do
    expect(ThatLanguage::Client::VERSION).not_to be nil
  end

  describe "#base_url" do
    def base_url_for(host)
      described_class.new(host: host).base_url
    end

    it "assumes http when the host carries no scheme" do
      expect(base_url_for("foo.bar")).to eq("http://foo.bar")
      expect(base_url_for("localhost:4567")).to eq("http://localhost:4567")
    end

    it "keeps an explicit scheme" do
      expect(base_url_for("https://foo.bar")).to eq("https://foo.bar")
      expect(base_url_for("http://foo.bar:4567")).to eq("http://foo.bar:4567")
    end

    it "does not leave a doubled slash before the endpoint" do
      expect(base_url_for("https://foo.bar/")).to eq("https://foo.bar")
    end
  end

  describe ".current" do
    subject { described_class.current }
    let(:second_current_client) { described_class.current }

    it { is_expected.to be_a(ThatLanguage::Client) }
    it { is_expected.to eq(second_current_client) }
  end

  describe ".config" do
    subject { described_class.config }

    it { is_expected.to be_a(ThatLanguage::Client::Config) }
    its(:host) { is_expected.to eq("localhost:4567") }
  end

  describe ".configure" do
    subject { described_class.config }

    before do
      described_class.configure do |config|
        config.host = "foo.bar"
      end
    end

    after do
      described_class.configure do |config|
        config.host = "localhost:4567"
      end
    end

    its(:host) { is_expected.to eq("foo.bar") }
  end
end
