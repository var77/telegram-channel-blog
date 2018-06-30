defmodule ChannelRepoTest do
  use ExUnit.Case
  doctest ChannelRepo

  test "greets the world" do
    assert ChannelRepo.hello() == :world
  end
end
