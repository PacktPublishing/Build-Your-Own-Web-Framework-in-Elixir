defmodule TasksWebTest do
  use ExUnit.Case
  doctest TasksWeb

  test "greets the world" do
    assert TasksWeb.hello() == :world
  end
end
