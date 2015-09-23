require 'spec_helper'

describe ThatLanguage::Client do
  subject { described_class.new(host: "foo.bar") }

  its(:host) { is_expected.to eq("foo.bar") }

  it 'has a version number' do
    expect(ThatLanguage::Client::VERSION).not_to be nil
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
    its(:host) { is_expected.to eq("detect-language.ruby-on-rails.guru") }
  end

  describe ".configure" do
    subject { described_class.config }

    before do
      described_class.configure do |config|
        config.host = "foo.bar"
      end
    end

    its(:host) { is_expected.to eq("foo.bar") }
  end
end
