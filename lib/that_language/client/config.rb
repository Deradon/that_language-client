module ThatLanguage
  class Client
    class Config
      attr_accessor :host

      def host
        @host ||= "that-language-api.ruby-on-rails.guru"
      end
    end
  end
end
