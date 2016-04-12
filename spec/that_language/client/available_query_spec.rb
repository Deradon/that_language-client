require 'spec_helper'

describe ThatLanguage::Client::AvailableQuery do
  subject(:query) { described_class.new }

  setup_stubbed_requests

  its(:endpoint) { is_expected.to eq("/available") }
  its(:available) {
    is_expected.to eq({
      "de" => "German",
      "en" => "English"
    })
  }
end
