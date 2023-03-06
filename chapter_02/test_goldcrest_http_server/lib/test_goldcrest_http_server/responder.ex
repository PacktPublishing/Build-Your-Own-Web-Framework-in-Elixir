defmodule TestGoldcrestHTTPServer.Responder do
  import Goldcrest.HTTPServer.ResponderHelpers

  def resp(_req, method, path) do
    cond do
      method == :GET && path == "/hello" ->
        http_response("Hello World")
        |> put_header("Content-type", "text/html")
        |> put_status(200)

      method == :GET && path == "/long-operation" ->
        # sleep for 5 seconds
        :timer.sleep(5000)

        http_response("Hello World LONG LONG")
        |> put_header("Content-type", "text/html")
        |> put_status(200)

      true ->
        http_response("Not Found")
        |> put_header("Content-type", "text/html")
        |> put_status(404)
    end
  end
end
