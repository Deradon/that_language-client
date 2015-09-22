require "detect_language"
require "detect_language/client/config"
require "detect_language/client/locale_query"
require "detect_language/client/version"

module DetectLanguage
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
