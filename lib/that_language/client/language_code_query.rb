require 'json'
require 'net/http'

module ThatLanguage
  class Client
    class LanguageCodeQuery
      attr_reader :text

      def initialize(text:, client: Client.current)
        @text = text
        @client = client
      end

      def language_code
        response.body
      end

      private

      attr_reader :client

      def response
        @response ||= Net::HTTP.post_form(URI(url), text: text)
      end

      def url
        "http://#{client.host}/language_code"
      end
    end
  end
end
