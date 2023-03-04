defmodule TestGoldcrestHttpServerTest do
  use ExUnit.Case
  doctest TestGoldcrestHttpServer

  test "greets the world" do
    assert TestGoldcrestHttpServer.hello() == :world
  end
end
