require "that_language/client/query"

module ThatLanguage
  class Client
    class LanguageQuery < Query
      # The core gem returns language *names* as symbols and language *codes*
      # as strings. JSON has no symbols, so the boundary is converted back here
      # -- otherwise this gem is not the drop-in replacement it claims to be.
      def language
        json["language"]&.to_sym
      end

      private

      def endpoint
        "/language"
      end
    end
  end
end
