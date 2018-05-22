require "socket"
module Ezdb
  class Server

    @port = 28468

    def initialize(port=28468)
      @port = port
    end

    def start
      server = TCPServer.new("localhost", @port)
      server.recv_buffer_size = 4096
      data = Hash(String, String).new

      loop do
        socket = server.accept
        if socket
          spawn do
            loop do
              if request = socket.gets
                request = request.split(" ").map{|item| item.strip }
                if request.size == 1
                  socket.puts("invalid")
                  next
                end
                command = request[0]
                key = request[1]

                if command == "set"
                  value = request[2]

                  data[key] = value

                  socket.puts(value)
                elsif command == "get"
                  value = data[key]

                  socket.puts(value)
                elsif command == "unset"
                  data[key] = ""
                  socket.puts(key)
                else
                  socket.puts("error: #{command} is not a valid command")
                end
              end
            end
          end
        end
      end
    end

  end
end
