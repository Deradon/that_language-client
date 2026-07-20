module ThatLanguage
  class Client
    class Config
      attr_writer :host

      # The default points at a service on this machine, which is what the
      # container image listens on:
      #
      #   docker run -p 4567:4567 that_language-service
      #
      # It used to be a hosted domain. That host went offline and the gem became
      # inert out of the box, with nothing to show for it but a connection
      # error -- so the default is now something the reader can start
      # themselves, and it cannot rot, because it is not somebody else's DNS
      # record.
      #
      # Point it at a real deployment with:
      #
      #   ThatLanguage::Client.configure { |c| c.host = "https://api.example.com" }
      def host
        @host ||= "localhost:4567"
      end
    end
  end
end
