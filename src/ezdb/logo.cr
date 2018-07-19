require "./constants"
#require "./console"

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

      HERE

#      logo << "ezdb v#{Ezdb::Console.bright}VERSION#{Ezdb::Console.reset}\n"
       logo += "ezdb vVERSION"

      puts logo.gsub("VERSION", Ezdb::VERSION)
    end
  end
end
