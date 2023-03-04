defmodule Goldcrest.Controller do
  import Plug.Conn

  def content_type(conn, content_type) do
    put_resp_content_type(conn, content_type)
  end

  def render(conn, :json, data) when is_map(data) do
    conn
    |> content_type("application/json")
    |> send_resp(200, Jason.encode!(data))
  end

  def render(conn, :json, data) when is_binary(data) do
    data = ensure_json!(data)

    conn
    |> content_type("application/json")
    |> send_resp(conn.status || 200, data)
  end

  def render(conn, :html, data) when is_binary(data) do
    conn
    |> content_type("text/html")
    |> send_resp(200, data)
  end

  def redirect(conn, to: url) do
    body = redirection_body(url)

    conn
    |> put_resp_header("location", url)
    |> content_type("text/html")
    |> send_resp(conn.status || 302, body)
  end

  defp redirection_body(url) do
    html = Plug.HTML.html_escape(url)

    "<html><body>You are being <a href=\"#{html}\">redirected</a>" <>
      ".</body></html>"
  end

  defp ensure_json!(data) do
    data
    |> Jason.decode!()
    |> Jason.encode!()
  end
end
