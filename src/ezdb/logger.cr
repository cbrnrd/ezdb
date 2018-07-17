require "logger"

module Ezdb
  class Logger < ::Logger
    @@instance : Ezdb::Logger = Ezdb::Logger.new(STDOUT)

    def self.build(io : (IO | String) = STDOUT, level : Int32 = 1, hostname : String = "127.0.0.1", port : Int32 = 28468)
      if io.is_a?(String)
        basename = File.basename(io, ".log")
        path = File.dirname(io)
        timestamp = Time.now.to_s("%Y%m%d%H%M%S")

        io = File.new("#{path}/#{basename}_#{timestamp}.log", "w")
      end

      @@instance = Ezdb::Logger.new(io)
      @@instance.level = Ezdb::Logger::Severity.new(level)
      @@instance.formatter = Ezdb::Logger::Formatter.new do |severity, datetime, progname, message, io|
        datetime = datetime.to_utc.to_s("%Y-%m-%d %H:%M:%S.%L")
        io << "[ezdb][#{hostname}:#{port}][#{datetime}][#{severity}] #{message}"
      end
    end

    def self.instance
      self.build if @@instance.nil?

      @@instance
    end
  end
end
