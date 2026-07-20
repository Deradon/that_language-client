require "that_language/client/query"
require "ostruct"

# TODO: Get rid of ostruct and use Client::Result
module ThatLanguage
  class Client
    class DetailsQuery < Query
      # The core gem's ResultSet#winner is `results.max`, where Result#<=>
      # compares `value`. Taking `results.first` instead would give the same
      # answer only for as long as the service keeps sorting -- the ordering
      # would be the service's promise rather than this gem's, and a service
      # that stopped sorting would silently change what `winner` means here
      # while the core gem carried on returning the highest-valued result.
      #
      # Ranking on `value` locally costs nothing and makes the two agree by
      # construction rather than by coincidence.
      def winner
        results.max_by(&:value)
      end

      # Descending by value, matching ResultSet#results (`_results.sort.reverse`)
      # rather than trusting the order the results arrived in.
      def results
        @results ||= json["results"]
                     .map { |result| OpenStruct.new(result.merge("language" => language_name(result["language"]))) }
                     .sort_by(&:value)
                     .reverse
      end

      private

      def endpoint
        "/details"
      end
    end
  end
end
