require 'spec_helper'

describe DetectLanguage::Client::Config do
  its(:host) { is_expected.to eq("detect-language.ruby-on-rails.guru") }

  describe "#host=" do
    before { subject.host = "foo.bar" }
    its(:host) { is_expected.to eq("foo.bar") }
  end
end
