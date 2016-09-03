require "socket"
require "logger"
require "./logger"
require "./command"
require "./memory"

module BoJack
  class Request
    @logger : ::Logger = BoJack::Logger.instance

    def initialize(@body : String, @socket : TCPSocket, @memory : BoJack::Memory(String, Array(String))); end

    def perform
      @logger.info("#{@socket.remote_address} requested: #{@body.strip}")
      params = parse(@body)
      command = BoJack::Command.from(params[:command])

      response = command.run(@memory, params)

      @socket.puts(response)
    rescue e : BoJack::Exceptions::Runtime
      message = "error: #{e.message}"
      @logger.error(message)
      @socket.puts(message)
    end

    private def parse(body) : Hash(Symbol, String | Array(String))
      body = body.split(" ").map { |item| item.strip }

      command = body[0]
      result = Hash(Symbol, String | Array(String)).new
      result[:command] = command

      result[:key] = body[1] if body[1]?
      result[:value] = body[2].split(",") if body[2]?

      result
    end
  end
end
