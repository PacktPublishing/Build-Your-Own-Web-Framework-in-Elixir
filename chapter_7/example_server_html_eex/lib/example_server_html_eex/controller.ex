defmodule ExampleServerHtmlEex.Controller do
  use Plug.Builder
  import Plug.Conn

  def call(conn, action: action) do
    conn = super(conn, [])

    apply(__MODULE__, action, [conn, conn.params])
  end

  def greet(conn, %{"greeting" => greeting}) do
    conn
    |> put_status(200)
    |> render("greet.html.eex", greeting: greeting)
  end

  defp render(conn, file, assigns) do
    ExampleServerHtmlEex.View.render(conn, file, assigns)
  end
end
