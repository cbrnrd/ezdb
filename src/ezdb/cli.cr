require "commander"
require "./server"
require "./constants"
require "./logger"
#require "./console"

module Ezdb
  class CLI
    def self.run(args)
      cli = Commander::Command.new do |command|
        command.use = "ezdb"

        command.commands.add do |command|
          command.use = "version"
          command.short = "Shows the version."
          command.long = command.short

          command.run do
            puts "ezdb v#{Ezdb::VERSION}"
          end
        end

        command.commands.add do |command|
          command.use = "daemon"
          command.short = "Start the ezdb daemon."
          command.long = command.short

          command.flags.add do |flag|
            flag.name = "hostname"
            flag.long = "--hostname"
            flag.default = "127.0.0.1"
            flag.description = "The local address to bind to."
          end

          command.flags.add do |flag|
            flag.name = "port"
            flag.long = "--port"
            flag.default = 28468
            flag.description = "Port."
          end

          command.flags.add do |flag|
            flag.name = "log"
            flag.long = "--log"
            flag.default = ""
            flag.description = "Log output file."
          end

          command.flags.add do |flag|
            flag.name = "log-level"
            flag.long = "--log-level"
            flag.default = 1
            flag.description = "Log severity."
          end

          command.run do |options, arguments|
            output =  if options.string["log"].empty?
                        STDOUT
                      else
                        options.string["log"]
                      end

            Ezdb::Logger.build(output, options.int["log-level"].as(Int32),
                                 options.string["hostname"], options.int["port"].as(Int32))

            Ezdb::Server.new(options.string["hostname"], options.int["port"]).start
          end
        end

        command.commands.add do |command|
          command.use = "console"
          command.short = "Starts a console."
          command.long = command.short

          command.flags.add do |flag|
            flag.name = "hostname"
            flag.long = "--hostname"
            flag.default = "127.0.0.1"
            flag.description = "The local address to connect to."
          end

          command.flags.add do |flag|
            flag.name = "port"
            flag.long = "--port"
            flag.default = 28468
            flag.description = "Port."
          end

          command.run do |options, arguments|
            #Ezdb::Console.new(options.string["hostname"], options.int["port"]).start
          end
        end
      end

      Commander.run(cli, args)
    end
  end
end
