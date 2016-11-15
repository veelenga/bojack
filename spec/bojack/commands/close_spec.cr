require "../../spec_helper"
require "../../../src/bojack/commands/close"

describe BoJack::Commands::Close do
  memory = BoJack::Memory(String, Array(String)).new

  it "raises a close connection exceptions" do
    expect_raises(BoJack::Exceptions::CloseConnection) do
      BoJack::Commands::Close.new.perform([0], memory, {} of Symbol => String)
    end
  end
end
