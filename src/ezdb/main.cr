require "./cli"

if ARGV.size == 0
  puts "\u001b[35;1mezdb\u001b[0m - use \u001b[37;1m`ezdb help`\u001b[0m or \u001b[37;1m`ezdb -h`\u001b[0m for options."
end

Ezdb::CLI.run(ARGV)
