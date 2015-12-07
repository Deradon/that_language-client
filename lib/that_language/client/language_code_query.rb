require "that_language/client/query"

module ThatLanguage
  class Client
    class LanguageCodeQuery < Query
      def language_code
        json["language_code"]
      end

      private

      def url
        "http://#{client.host}/language_code"
      end
    end
  end
end
