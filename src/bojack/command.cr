require "./commands/*"
require "./exceptions"

module BoJack
  module Command
    class InvalidCommand < BoJack::Exceptions::Runtime; end

    COMMANDS = {
      "append" => BoJack::Commands::Append,
      "delete" => BoJack::Commands::Delete,
      "get" => BoJack::Commands::Get,
      "increment" => BoJack::Commands::Increment,
      "pop" => BoJack::Commands::Pop,
      "set" => BoJack::Commands::Set,
      "size" => BoJack::Commands::Size,
      "ping" => BoJack::Commands::Ping,
      "close" => BoJack::Commands::Close,
    }

    def self.from(keyword) : BoJack::Commands::Command
      raise BoJack::Command::InvalidCommand.new("'#{keyword}' is not a valid command") unless COMMANDS.has_key?(keyword)

      COMMANDS[keyword].new
    end
  end
end
