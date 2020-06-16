defmodule ChannelBotTest do
  use ExUnit.Case
  doctest ChannelBot

  test "greets the world" do
    assert ChannelBot.hello() == :world
  end
end
