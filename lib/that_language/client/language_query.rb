require "that_language/client/query"

module ThatLanguage
  class Client
    class LanguageQuery < Query
      def language
        language_name(json["language"])
      end

      private

      def endpoint
        "/language"
      end
    end
  end
end
