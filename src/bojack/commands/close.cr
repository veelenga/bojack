require "../exceptions"
require "./command"

module BoJack
  module Commands
    class Close < BoJack::Commands::Command
      def validate; end

      def perform(socket, memory, params)
        raise BoJack::Exceptions::CloseConnection.new("Close command called")
      end
    end
  end
end
