require 'spec_helper'

describe DetectLanguage do
  let(:text) { "der the of" }

  describe ".locale(text)" do
    subject { described_class.locale(text) }
    it { is_expected.to eq("en") }
  end

  describe ".monkeypatch(klass)" do
    let(:klass) { Class.new(String) }
    before { described_class.monkeypatch(klass) }

    describe "<MonkeypatchedClass>#locale(text)" do
      subject { klass.new(text) }
      its(:locale) { is_expected.to eq("en") }
    end
  end
end
