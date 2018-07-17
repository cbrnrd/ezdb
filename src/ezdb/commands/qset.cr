require "./command"

module Ezdb
module Commands
  class QSet < Ezdb::Commands::Command
    def validate
      required(:key)
      required(:value)
    end

    def perform(socket, memory, params)
      key = params[:key].to_s
      value = params[:value]
      value = [value] if value.is_a?(String)

      data = memory.write(key, value)
    end
  end
end
end
