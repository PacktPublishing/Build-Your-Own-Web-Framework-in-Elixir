defmodule CowboyExample.ServerTest do
  use ExUnit.Case

  setup_all do
    Finch.start_link(name: CowboyExample.Finch)

    :ok
  end

  describe "GET /" do
    test "returns Hello World with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hello World"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end
  end

  describe "GET /greeting/:who" do
    test "returns Hello `:who` with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/Elixir")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hello Elixir"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end

    test "returns `greeting` `:who` with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/Elixir?greeting=Hola")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hola Elixir"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end
  end
end
