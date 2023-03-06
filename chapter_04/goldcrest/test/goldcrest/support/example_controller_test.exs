defmodule Goldcrest.ExampleControllerTest do
  use ExUnit.Case
  use Plug.Test

  describe "GET /greet" do
    test "responds with 200 status" do
      conn = conn(:get, "/greet")

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 200
      assert conn.resp_body == Jason.encode!(%{status: "ok"})
    end
  end

  describe "GET /redirect_greet" do
    test "responds with a redirect status" do
      conn = conn(:get, "/redirect_greet")

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 302
      assert conn.resp_body =~ "You are being"
      assert conn.resp_body =~ "redirected"
      assert Plug.Conn.get_resp_header(conn, "location") == ["/greet"]
    end
  end
end
