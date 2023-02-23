defmodule Plug.Goldcrest.HTTPServer.Conn do
  import Goldcrest.HTTPServer.ResponderHelpers

  @moduledoc false
  @behaviour Plug.Conn.Adapter

  @impl true
  def send_resp({req, method, path}, status, headers, body) do
    resp_string =
      body
      |> http_response()
      |> apply_headers(headers)
      |> put_status(status)
      |> Goldcrest.HTTPResponse.to_string()

    :gen_tcp.send(req, resp_string)

    :gen_tcp.close(req)

    {:ok, nil, {req, method, path}}
  end

  defp apply_headers(resp, headers) do
    Enum.reduce(headers, resp, fn {k, v}, resp ->
      put_header(resp, k, v)
    end)
  end

  defp status_to_string(status) do
    Integer.to_string(status) <> " " <> Plug.Conn.Status.reason_phrase(status)
  end
end
