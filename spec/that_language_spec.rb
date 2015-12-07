require 'spec_helper'

describe ThatLanguage do
  setup_stubbed_requests

  let(:text) { "der the of" }

  describe ".language(text)" do
    subject { described_class.language(text) }
    it { is_expected.to eq("English") }
  end

  describe ".language_code(text)" do
    subject { described_class.language_code(text) }
    it { is_expected.to eq("en") }
  end

  describe ".detect(text)" do
    subject { described_class.detect(text) }

    its(:language) { is_expected.to eq("English") }
    its(:language_code) { is_expected.to eq("en") }
    its(:confidence) { is_expected.to eq(0.8) }
  end

  describe ".details(text)" do
    subject(:query) { described_class.details(text) }

    it { is_expected.to be_a(ThatLanguage::Client::DetailsQuery) }

    describe "#winner" do
      subject { query.winner }
      its(:language) { is_expected.to eq("English") }
    end

    describe "#results" do
      subject { query.results }
      its(:length) { is_expected.to eq(2) }
    end

    describe "#to_h" do
      subject { query.to_h }
      it { is_expected.to be_a(Hash) }
      it { is_expected.to include("results") }
    end
  end

  describe ".available" do
    subject { described_class.available }

    it { is_expected.to include("de" => "German") }
    it { is_expected.to include("en" => "English") }
  end

  describe ".available_languages" do
    subject { described_class.available_languages }

    it { is_expected.to include("English") }
    it { is_expected.to include("German") }
  end

  describe ".available_language_codes" do
    subject { described_class.available_language_codes }

    it { is_expected.to include("de") }
    it { is_expected.to include("en") }
  end

  describe ".monkeypatch(klass)" do
    let(:klass) { Class.new(String) }
    before { described_class.monkeypatch(klass) }

    describe "<MonkeypatchedClass>#language_code(text)" do
      subject { klass.new(text) }
      its(:language_code) { is_expected.to eq("en") }
    end
  end
end
