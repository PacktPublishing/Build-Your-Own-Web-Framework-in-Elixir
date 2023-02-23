defmodule ExampleServerHtmlEex.ControllerTest do
  use ExUnit.Case

  use Plug.Test

  describe "GET /greet" do
    test "responds with an HTML document" do
      conn = conn(:get, "/greet?greeting=Hola")

      conn = ExampleServerHtmlEex.Router.call(conn, [])

      assert conn.status == 200
      {:ok, html} = Floki.parse_document(conn.resp_body)

      heading =
        html
        |> Floki.find("h1")
        |> Floki.text()

      assert heading == "Hola World!"
    end

    test "raises error if no greeting provided" do
      conn = conn(:get, "/greet")

      assert_raise(Plug.Conn.WrapperError, fn ->
        ExampleServerHtmlEex.Router.call(conn, [])
      end)
    end
  end
end
