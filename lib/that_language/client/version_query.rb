require "that_language/client/query"

module ThatLanguage
  class Client
    class VersionQuery < Query
      # FIXME: do not pass text to super
      def initialize(client: Client.current)
        super(text: "", client: client)
      end

      def version
        json["version"]
      end

      private

      def endpoint
        "/version"
      end
    end
  end
end
