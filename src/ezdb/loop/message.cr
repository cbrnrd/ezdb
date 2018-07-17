require "socket"
require "../request"

module Ezdb
  module EventLoop
    class Message
      def initialize(@socket : TCPSocket, @channel : ::Channel::Unbuffered(Ezdb::Request)); end

      def start
        spawn do
          loop do
            message = @socket.gets
            break unless message

            @channel.send(Ezdb::Request.new(message, @socket))
          end
        end
      end
    end
  end
end
