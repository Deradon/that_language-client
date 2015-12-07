module ThatLanguageClientSpecHelper
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def setup_stubbed_requests
      before do
        base_url = "http://detect-language.ruby-on-rails.guru"
        request_body = { "text" => "der the of" }
        details_body = <<-JSON
{
  "results": [
    {"language":"English","language_code":"en","confidence":0.8,"value":2.0,"hit_ratio":1.0,"hit_count":2,"words_count":2},
    {"language":"German","language_code":"de","confidence":0.5,"value":0.8,"hit_ratio":0.5,"hit_count":1,"words_count":2}
  ]
}
JSON

        stub_request(:post, "#{base_url}/language_code")
          .with(body: request_body)
          .to_return(body: '{"language_code":"en"}')

        stub_request(:post, "#{base_url}/language")
          .with(body: request_body)
          .to_return(body: '{"language":"English"}')

        stub_request(:post, "#{base_url}/detect")
          .with(body: request_body)
          .to_return(body: '{"language":"English","language_code":"en","confidence":0.8}')

        stub_request(:post, "#{base_url}/details")
          .with(body: request_body)
          .to_return(body: details_body)
      end
    end
  end
end
