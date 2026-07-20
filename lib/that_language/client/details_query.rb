require "that_language/client/query"
require "ostruct"

# TODO: Get rid of ostruct and use Client::Result
module ThatLanguage
  class Client
    class DetailsQuery < Query
      def winner
        results.first
      end

      def results
        @results ||= json["results"].map do |result|
          # Symbol language name, string language code -- see
          # LanguageQuery#language for why the conversion happens here.
          OpenStruct.new(result.merge("language" => result["language"]&.to_sym))
        end
      end

      private

      def endpoint
        "/details"
      end
    end
  end
end
