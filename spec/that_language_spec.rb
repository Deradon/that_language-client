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

  describe ".monkeypatch(klass)" do
    let(:klass) { Class.new(String) }
    before { described_class.monkeypatch(klass) }

    describe "<MonkeypatchedClass>#language_code(text)" do
      subject { klass.new(text) }
      its(:language_code) { is_expected.to eq("en") }
    end
  end
end
