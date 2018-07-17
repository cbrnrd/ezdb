require "./constants"

module Ezdb
  class Logo
    def self.render(logger)
      logo = <<-'HERE'
                    _ _
                   | | |
         ___ ______| | |__
        / _ \_  / _` | '_ \
        |  __/ / (_| | |_) |
        \___/___\__,_|_.__/


      ezdb vVERSION
      HERE

      puts logo.gsub("VERSION", Ezdb::VERSION)
    end
  end
end
