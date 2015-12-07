require 'json'
require 'net/http'

module ThatLanguage
  class Client
    class Query
      attr_reader :text

      def initialize(text:, client: Client.current)
        @text = text
        @client = client
      end

      private

      attr_reader :client

      def json
        @json ||= JSON.parse(response.body)
      end

      def response
        @response ||= Net::HTTP.post_form(URI(url), text: text)
      end

      def url
        "http://#{client.host}#{endpoint}"
      end

      def endpoint
        fail NotImplementedError
      end
    end
  end
end
