require "that_language"
require "that_language/client/config"
require "that_language/client/detect_query"
require "that_language/client/language_query"
require "that_language/client/language_code_query"
require "that_language/client/version"

module ThatLanguage
  class Client
    attr_reader :host

    def initialize(host:)
      @host = host
    end

    def self.current
      @current ||= Client.new(host: config.host)
    end

    def self.config
      @config ||= Config.new
    end

    def self.configure
      yield(config)
    end
  end
end
