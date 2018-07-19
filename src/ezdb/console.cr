require "readline"
require "ezdb-client"

module Ezdb
class Console

  class Colors
    def self.purple
      "\u001b[35m"
    end

    def self.red
      "\u001b[31m"
    end

    def self.reset
      "\u001b[0m"
    end

    def self.bright
      "\u001b[37;1m"
    end
  end

  @client : Ezdb::Client?

  def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 28468)
    begin
      @client = Ezdb::Client.new(@hostname, @port)
    rescue e
      puts Ezdb::Console::Colors.red + e.message Ezdb::Console::Colors.reset
      exit -1
    end
  end

  def start
    client = @client
    return unless client
    loop do
      input = Readline.readline(Ezdb::Console::Colors.purple + "ezdb" + Ezdb::Console::Colors.reset + "> ")
      puts client.sent(input)
      break if input == "exit"
    end
  end
end
end
