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
        @results ||= json["results"].map { |result| OpenStruct.new(result) }
      end

      private

      def endpoint
        "/details"
      end
    end
  end
end
