require "./command"

module Ezdb
module Commands
  class Hello < Ezdb::Commands::Command
    def validate
    end

    def perform(sock, mem, params)
      "Hello there"
    end
  end
end
end
