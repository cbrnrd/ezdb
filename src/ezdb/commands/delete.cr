require "./command"

module Ezdb
module Commands
  class Delete < Ezdb::Commands::Command
    def validate
      required(:key)
    end

    def perform(sock, mem, params)
      key = params[:key].to_s

      if key == "*"
        mem.reset
      else
        mem.delete(key).first
      end
    end
  end
end
end
