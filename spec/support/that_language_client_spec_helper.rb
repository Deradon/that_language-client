module ThatLanguageClientSpecHelper
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def setup_stubbed_requests
      before do
        base_url = "http://detect-language.ruby-on-rails.guru"
        body = { "text" => "der the of" }

        stub_request(:post, "#{base_url}/language_code")
          .with(body: body)
          .to_return(body: '{"language_code":"en"}')

        stub_request(:post, "#{base_url}/language")
          .with(body: body)
          .to_return(body: '{"language":"English"}')

        stub_request(:post, "#{base_url}/detect")
          .with(body: body)
          .to_return(body: '{"language":"English","language_code":"en","confidence":0.8}')
      end
    end
  end
end
