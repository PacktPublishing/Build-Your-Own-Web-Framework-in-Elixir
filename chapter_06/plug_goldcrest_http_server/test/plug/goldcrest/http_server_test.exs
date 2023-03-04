defmodule Plug.Goldcrest.HTTPServerTest do
  use ExUnit.Case
  doctest Plug.Goldcrest.HTTPServer

  test "greets the world" do
    assert Plug.Goldcrest.HTTPServer.hello() == :world
  end
end
