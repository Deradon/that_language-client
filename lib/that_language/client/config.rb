module ThatLanguage
  class Client
    class Config
      attr_accessor :host

      def host
        @host ||= "detect-language.ruby-on-rails.guru"
      end
    end
  end
end
