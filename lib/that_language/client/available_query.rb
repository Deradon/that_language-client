require "that_language/client/query"

module ThatLanguage
  class Client
    class AvailableQuery < Query
      # FIXME: do not pass text to super
      def initialize(client: Client.current)
        super(text: "", client: client)
      end

      # The core gem keys this hash by symbol and values it with symbols too
      # (`{ak: :Akan}`). JSON gives strings for both. See
      # LanguageQuery#language.
      def available
        @available ||= json["available"].to_h { |code, name| [code.to_sym, name.to_sym] }
      end

      private

      def endpoint
        "/available"
      end
    end
  end
end
