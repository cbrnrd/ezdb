require "socket"
require "out"
require "logger"
require "json"

module Ezdb
class Server

  @port = 28468

  #
  # Initializes the Ezdb::Server and sets @port
  #
  def initialize(port=28468)
    @port = port
  end

  #
  # Starts the listener in a forked process.
  #
  def start(bufsize=4096)
    logger = Logger.new(STDOUT)
    logger.info("Starting listening daemon on tcp/#{@port}")
    server = TCPServer.new("localhost", @port)
    logger.info("recv_buffer_size is set to 4096")
    server.recv_buffer_size = bufsize
    data = Hash(String, String).new
    logger.warn("Forking daemon to background.")
    fork do
      loop do
        socket = server.accept
        logger.info("Got connection. Socket: #{socket}")
        if socket
          spawn do
            socket.puts("ezdb v#{Ezdb::VERSION}")
            loop do
              if request = socket.gets
                request = request.split(" ").map{|item| item.strip }

                if request[0] == "?" || request[0] == ".help"
                  socket.puts(".help/? - show this message\n.exit - exit the console")
                  next
                end

                if request[0] == ".exit"
                  socket.close
                end

                if request.size == 1
                  socket.puts("invalid")
                  next
                end

                command = request[0]
                key = request[1]

                if command == "set"
                  if request.size < 3
                    socket.puts("invalid syntax. -> set key value")
                    next
                  end
                  value = request[2]

                  data[key] = value

                  socket.puts(value)
                elsif command == "get"
                  if key == "*"
                    socket.puts(data.to_pretty_json)
                    next
                  end
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
end
