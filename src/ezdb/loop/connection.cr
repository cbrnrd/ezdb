require "socket"
require "../logger"
require "../request"
require "./message"

module Ezdb
  module EventLoop
    class Connection
      @logger : Ezdb::Logger = Ezdb::Logger.instance

      def initialize(@server : TCPServer, @channel : ::Channel::Unbuffered(Ezdb::Request)); end

      def start
        loop do
          if socket = @server.accept?
            @logger.info("#{socket.remote_address} connected to ezdb daemon")
            Message.new(socket, @channel).start
          end
        end
      end
    end
  end
end
