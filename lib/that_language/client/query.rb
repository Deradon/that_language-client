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

      def to_h
        json
      end

      private

      attr_reader :client

      # The core gem returns language *names* as symbols and language *codes*
      # as strings. JSON has neither, so every name crossing this boundary is
      # converted back -- without it this gem is not the drop-in replacement it
      # claims to be. Every subclass that surfaces a language name goes through
      # here, so the rule is stated once.
      def language_name(value)
        value&.to_sym
      end

      def json
        @json ||= JSON.parse(response.body)
      end

      def response
        @response ||= Net::HTTP.post_form(URI(url), text: text)
      end

      def url
        "#{client.base_url}#{endpoint}"
      end

      def endpoint
        fail NotImplementedError
      end
    end
  end
end
