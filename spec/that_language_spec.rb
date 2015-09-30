require 'spec_helper'

describe ThatLanguage do
  let(:text) { "der the of" }

  before do
    stub_request(:post, "http://detect-language.ruby-on-rails.guru/language_code")
      .with(body: { "text" => "der the of" })
      .to_return(body: 'en')
  end

  describe ".language_code(text)" do
    subject { described_class.language_code(text) }
    it { is_expected.to eq("en") }
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
