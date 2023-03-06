defmodule Goldcrest.ExampleController do
  import Plug.Conn
  import Goldcrest.Controller

  def call(conn, action: action) do
    apply(__MODULE__, action, [conn, conn.params])
  end

  def greet(conn, _params) do
    conn
    |> put_status(200)
    |> render(:json, %{status: "ok"})
  end

  def redirect_greet(conn, params) do
    conn |> redirect(to: "/greet")
  end
end
