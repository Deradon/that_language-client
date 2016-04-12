require "that_language/client/query"

module ThatLanguage
  class Client
    class AvailableQuery < Query
      # FIXME: do not pass text to super
      def initialize(client: Client.current)
        super(text: "", client: client)
      end

      def available
        json["available"]
      end

      private

      def endpoint
        "/available"
      end
    end
  end
end
