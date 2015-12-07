require 'spec_helper'

describe ThatLanguage::Client::DetailsQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  its(:endpoint) { is_expected.to eq("/details") }

  describe "#results" do
    subject(:results) { query.results }

    it { is_expected.to be_a(Array) }
    its(:length) { is_expected.to eq(2) }

    describe "an entry" do
      subject { results.first }
      it { is_expected.to be_a(OpenStruct) } # TODO: Use Client::Result
    end
  end

  describe "#winner" do
    subject { query.winner }

    its(:language) { is_expected.to eq("English") }
    its(:language_code) { is_expected.to eq("en") }
    its(:confidence) { is_expected.to eq(0.8) }
    its(:value) { is_expected.to eq(2.0) }
    its(:hit_ratio) { is_expected.to eq(1.0) }
    its(:hit_count) { is_expected.to eq(2) }
    its(:words_count) { is_expected.to eq(2) }
  end

  describe "#to_h" do
    subject { query.to_h }

    specify do
      expect(subject).to eq({
        "results" => [
           {
             "language" => "English",
             "language_code" => "en",
             "confidence" => 0.8,
             "value" => 2.0,
             "hit_ratio" => 1.0,
             "hit_count" => 2,
             "words_count" => 2
          },
          {
            "language" => "German",
            "language_code" => "de",
            "confidence" => 0.5,
            "value" => 0.8,
            "hit_ratio" => 0.5,
            "hit_count" => 1,
            "words_count" => 2
          }
        ]}
      )
    end
  end
end
