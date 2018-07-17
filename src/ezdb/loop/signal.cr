require "socket"
require "../logger"

module Ezdb
  module EventLoop
    class Signal
      @logger : Ezdb::Logger = Ezdb::Logger.instance

      def watch(server : TCPServer)
        ::Signal::INT.trap do
          @logger.info("Ezdb is exiting.")

          server.close

          exit
        end
      end
    end
  end
end
