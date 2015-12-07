require 'spec_helper'
require 'support/that_language_client_spec_helper'

describe ThatLanguage do
  include ThatLanguageClientSpecHelper

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

  describe ".monkeypatch(klass)" do
    let(:klass) { Class.new(String) }
    before { described_class.monkeypatch(klass) }

    describe "<MonkeypatchedClass>#language_code(text)" do
      subject { klass.new(text) }
      its(:language_code) { is_expected.to eq("en") }
    end
  end
end
