require "../exceptions"

module BoJack
  module Commands
    abstract class Command
      class MissingRequiredParam < BoJack::Exceptions::Runtime; end
      class InvalidArgument < BoJack::Exceptions::Runtime; end

      def initialize
        @params = Hash(Symbol, String | Array(String)).new
      end

      def run(memory, params : Hash(Symbol, String | Array(String)))
        @params = params
        validate

        perform(memory, params)
      end

      private abstract def perform(memory, params : Hash(Symbol, String | Array(String))) : String | Array(String)

      private abstract def validate

      private def required(name : Symbol)
        raise BoJack::Commands::Command::MissingRequiredParam.new("param '#{name}' is required but not present") unless @params.has_key?(name)
      end
    end
  end
end
