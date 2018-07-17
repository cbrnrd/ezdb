require "readline"
require "ezdb-client"

module Ezdb
class Console

  #TODO
  class Colors
    def self.purple
      ""
    end

    def self.red
      ""
    end

    def self.reset
      ""
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
