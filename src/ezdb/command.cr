require "./commands/*"

module Ezdb
module Command
  class InvalidCommandException < Exception; end;

  COMMANDS = {
    "append" => Ezdb::Commands::Append,
    "delete" => Ezdb::Commands::Delete,
    "qset"   => Ezdb::Commands::QSet,
    "unset"  => Ezdb::Commands::Unset,
    "get"    => Ezdb::Commands::Get,
    "inc"    => Ezdb::Commands::Inc,
    "pop"    => Ezdb::Commands::Pop,
    "set"    => Ezdb::Commands::Set,
    "size"   => Ezdb::Commands::Size,
    "hello"  => Ezdb::Commands::Hello,
    "exit"   => Ezdb::Commands::Exit
  }

  def self.from(keyw) : Ezdb::Commands::Command
    raise Ezdb::Command::InvalidCommandException.new("Invalid command: '#{keyw}'")
    COMMANDS[keyw].new
  end
end
end
