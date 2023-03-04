defmodule CowboyExampleTest do
  use ExUnit.Case
  doctest CowboyExample

  test "greets the world" do
    assert CowboyExample.hello() == :world
  end
end
