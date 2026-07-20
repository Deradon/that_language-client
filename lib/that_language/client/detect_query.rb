require "that_language/client/query"

module ThatLanguage
  class Client
    class DetectQuery < Query
      # Symbol, to match the core gem. See LanguageQuery#language.
      def language
        json["language"]&.to_sym
      end

      def language_code
        json["language_code"]
      end

      def confidence
        json["confidence"]
      end

      private

      def endpoint
        "/detect"
      end
    end
  end
end
