defmodule ExampleServerHtmlEex.Controller do
  use Plug.Builder
  import Plug.Conn
  import Goldcrest.Controller

  def call(conn, action: action) do
    conn = super(conn, [])

    apply(__MODULE__, action, [conn, conn.params])
  end

  def greet(conn, %{"greeting" => greeting}) do
    conn
    |> put_status(200)
    |> render_html("greet.html.eex", greeting: greeting)
  end

  require EEx

  defp render_html(conn, file, assigns) do
    contents =
      file
      |> html_file_path()
      |> EEx.eval_file(assigns: assigns)

    render(conn, :html, contents)
  end

  defp html_file_path(file) do
    Path.join([
      :code.priv_dir(:example_server_html_eex),
      "templates",
      file
    ])
  end
end
