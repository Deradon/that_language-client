require "that_language/client/query"

module ThatLanguage
  class Client
    class DetectQuery < Query
      def language
        json["language"]
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
