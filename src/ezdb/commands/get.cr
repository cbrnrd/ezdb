require "./command"

module Ezdb
module Commands
  class Get < Ezdb::Commands::Command
    def validate
      required(:key)
    end

    def perform(sock, mem, params)
      key = params[:key].to_s
      data = mem.read(key)

      if data.size == 1
        data.first
      else
        data
      end
    end
  end
end
end
