defmodule Goldcrest.ExampleController do
  use Plug.Builder
  import Plug.Conn
  import Goldcrest.Controller

  def call(conn, action: action) do
    conn = super(conn, [])

    unless conn.state == :sent or conn.halted do
      apply(__MODULE__, action, [conn, conn.params])
    else
      conn
    end
  end

  plug :ensure_authorized!

  def greet(conn, _params) do
    conn
    |> render(:json, %{status: "ok"})
  end

  def redirect_greet(conn, _params) do
    conn
    |> redirect(to: "/greet")
  end

  defp ensure_authorized!(conn, _opts) do
    if authorized?(conn) do
      conn
    else
      conn
      |> render(:json, %{status: "error"})
      |> halt()
    end
  end

  defp authorized?(conn), do: conn.remote_ip == {127, 0, 0, 1}
end
