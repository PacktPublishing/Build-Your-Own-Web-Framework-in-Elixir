defmodule Goldcrest.HTTPServerTest do
  use ExUnit.Case
  doctest Goldcrest.HTTPServer

  test "greets the world" do
    assert Goldcrest.HTTPServer.hello() == :world
  end
end
