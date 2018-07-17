require "./command"

module Ezdb
module Commands
  class Exit < Ezdb::Commands::Command
    def validate; end

    def perform(sock, mem, params)
      sock.close

      "Closing connection to #{sock.remote_address}."
    end
  end
end
end
