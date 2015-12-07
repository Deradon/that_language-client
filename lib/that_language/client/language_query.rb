require "that_language/client/query"

module ThatLanguage
  class Client
    class LanguageQuery < Query
      def language
        json["language"]
      end

      private

      def url
        "http://#{client.host}/language"
      end
    end
  end
end
