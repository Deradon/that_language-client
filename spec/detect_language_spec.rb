require 'spec_helper'

describe DetectLanguage do
  let(:text) { "der the of" }

  before do
    stub_request(:post, "http://detect-language.ruby-on-rails.guru/language")
      .with(body: { "text" => "der the of" })
      .to_return(body: '{"locale":"en","value":0.3,"score":0.2,"percentage":0.28,"hit_ratio":0.8,"hit_count":4,"words_count":5}')
  end

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
