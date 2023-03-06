defmodule Goldcrest.ExampleControllerTest do
  use ExUnit.Case
  use Plug.Test

  describe "GET /greet" do
    test "when not authorized responds with 401 status" do
      conn = conn(:get, "/greet")

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 401
      assert conn.resp_body == Jason.encode!(%{status: "Unauthorized"})
    end

    test "when authorized responds with 200 status" do
      conn = conn(:get, "/greet") |> put_auth_headers()

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 200
      assert conn.resp_body == Jason.encode!(%{status: "ok"})
    end
  end

  describe "GET /redirect_greet" do
    test "when not authorized responds with 401 status" do
      conn = conn(:get, "/redirect_greet")

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 401
      assert conn.resp_body == Jason.encode!(%{status: "Unauthorized"})
    end

    test "when authorized with bad params responds error" do
      conn = conn(:get, "/redirect_greet") |> put_auth_headers()

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 500
      assert conn.resp_body =~ "bad params"
    end

    test "when authorized with valid params redirects" do
      conn =
        :get
        |> conn("/redirect_greet", %{"greet" => "true"})
        |> put_auth_headers()

      conn = Goldcrest.ExampleRouter.call(conn, [])

      assert conn.status == 302
      assert conn.resp_body =~ "You are being"
      assert conn.resp_body =~ "redirected"
      assert Plug.Conn.get_resp_header(conn, "location") == ["/greet"]
    end
  end

  defp put_auth_headers(conn) do
    put_req_header(conn, "authorization", "Bearer secret")
  end
end
