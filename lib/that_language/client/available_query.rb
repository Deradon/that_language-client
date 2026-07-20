require "that_language/client/query"

module ThatLanguage
  class Client
    class AvailableQuery < Query
      # FIXME: do not pass text to super
      def initialize(client: Client.current)
        super(text: "", client: client)
      end

      # The exception to the rule in Query#language_name: this hash is keyed by
      # symbol in the core gem (`{ak: :Akan}`), so the *code* is a symbol here
      # even though language_code(text) returns a string.
      def available
        @available ||= json["available"].to_h { |code, name| [code.to_sym, language_name(name)] }
      end

      private

      def endpoint
        "/available"
      end
    end
  end
end
