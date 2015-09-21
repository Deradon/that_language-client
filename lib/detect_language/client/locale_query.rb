require 'json'
require 'net/http'

module DetectLanguage
  class Client
    class LocaleQuery
      attr_reader :text

      def initialize(text:, client: Client.current)
        @text = text
        @client = client
      end

      def locale
        to_h["locale"]
      end

      def to_h
        @_to_h ||= JSON.parse(body)
      end

      private

      attr_reader :client

      def body
        @body ||= response.body
      end

      def response
        @response ||= Net::HTTP.post_form(URI(url), text: text)
      end

      def url
        "http://#{client.host}/language"
      end
    end
  end
end
