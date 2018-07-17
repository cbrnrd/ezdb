require "./command"

module Ezdb
module Commands

  class Append < Ezdb::Commands::Command

    def validate
      required(:key)
      required(:value)
    end

    def perform(sock, mem, params)
      key = params[:key].to_s
      value = params[:value]
      value = [value] if value.is_a?(String)
    end
  end

end
end
