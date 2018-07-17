require "./command"

module Ezdb
module Commands
  class Unset < Ezdb::Commands::Command
    def validate
      required(:key)
    end

    def perform(sock, mem, params)
      key = params[:key].to_s

      mem.write(key, [""])

    end
  end
end
end
