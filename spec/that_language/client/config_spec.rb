require 'spec_helper'

describe ThatLanguage::Client::Config do
  its(:host) { is_expected.to eq("localhost:4567") }

  describe "#host=" do
    before { subject.host = "foo.bar" }
    after { subject.host = "localhost:4567" }

    its(:host) { is_expected.to eq("foo.bar") }
  end
end
