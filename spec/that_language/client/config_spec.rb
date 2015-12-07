require 'spec_helper'

describe ThatLanguage::Client::Config do
  its(:host) { is_expected.to eq("that-language-api.ruby-on-rails.guru") }

  describe "#host=" do
    before { subject.host = "foo.bar" }
    after { subject.host = "that-language-api.ruby-on-rails.guru" }

    its(:host) { is_expected.to eq("foo.bar") }
  end
end
