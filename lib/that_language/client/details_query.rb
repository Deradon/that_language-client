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
          OpenStruct.new(result.merge("language" => language_name(result["language"])))
        end
      end

      private

      def endpoint
        "/details"
      end
    end
  end
end
