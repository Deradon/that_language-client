require 'spec_helper'

describe ThatLanguage::Client::Config do
  its(:host) { is_expected.to eq("detect-language.ruby-on-rails.guru") }

  describe "#host=" do
    before { subject.host = "foo.bar" }
    its(:host) { is_expected.to eq("foo.bar") }
  end
end
