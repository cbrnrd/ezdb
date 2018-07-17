require "./command"

module Ezdb
module Commands
  class Size < Ezdb::Commands::Command
    def validate
    end

    def perform(sock, mem, params)
      mem.size.to_s
    end
  end
end
end
