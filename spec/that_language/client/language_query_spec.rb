require 'spec_helper'

describe ThatLanguage::Client::LanguageQuery do
  subject(:query) { described_class.new(text: text) }
  let(:text) { "der the of" }

  setup_stubbed_requests

  its(:endpoint) { is_expected.to eq("/language") }
  its(:language) { is_expected.to eq("English") }
end
