require "socket"
require "./memory"
require "./logger"
require "./request"
require "./logo"
require "./loop/*"

module Ezdb
class Server
  @logger: Ezdb::Logger = Ezdb::Logger.instance
  @@memory: Ezdb::Memory(String, Array(String)) = Ezdb::Memory(String, Array(String)).new

  def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 28468, @forked = false)
    @server = TCPServer.new(@hostname, @port)
    @server.tcp_nodelay = true
    @server.recv_buffer_size = 4096
  end

  def start
    if @forked
      fork do
        logo
        handle_trap
        start_conn_loop
      end
    else
      logo
      handle_trap
      start_conn_loop
    end
  end

  private def logo
    Ezdb::Logo.render(@logger)
  end

  private def handle_trap
    Ezdb::EventLoop::Signal.new.watch(@server)
  end

  private def start_conn_loop
    @logger.info("Ezdb running at #{@hostname}:#{@port}")
    channel = Channel::Unbuffered(Ezdb::Request).new
    Ezdb::EventLoop::Channel(Ezdb::Request).new(channel).start
    Ezdb::EventLoop::Connection.new(@server, channel).start
  end

  def self.memory
    @@memory
  end

end
end
