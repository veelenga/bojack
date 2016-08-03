module Bojack
  class Params
    @command : String
    @key : String
    @value : String
    getter :command, :key, :value

    def initialize(@command, @key, @value); end

    def self.from(request : String)
      request = request.split(" ").map { |item| item.strip }

      command = ""
      key = ""
      value = ""

      begin
        command = request[0]
      rescue
      end

      begin
        key = request[1]
      rescue
      end

      begin
        value = request[2]
      rescue
      end

      Params.new(command, key, value)
    end
  end
end
