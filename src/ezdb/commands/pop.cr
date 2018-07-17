require "./command"

module Ezdb
module Commands
  class Pop < Ezdb::Commands::Command
    def validate
      required(:key)
    end

    def perform(sock, mem, params)
      key = params[:key].to_s
      list = mem.read(key)
      return nil if list.empty?
      list.pop
    end
  end
end
end
