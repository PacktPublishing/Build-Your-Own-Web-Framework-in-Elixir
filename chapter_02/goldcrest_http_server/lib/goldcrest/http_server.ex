defmodule Goldcrest.HTTPServer do
  require Logger

  @server_options [
    active: false,
    packet: :http_bin,
    reuseaddr: true
  ]

  def start(port) do
    ensure_configured!()

    case :gen_tcp.listen(port, @server_options) do
      {:ok, sock} ->
        Logger.info("Started a webserver on port #{port}")

        listen(sock)

      {:error, error} ->
        Logger.error("Cannot start server on port #{port}: #{error}")
    end
  end

  defp ensure_configured! do
    case responder() do
      nil -> raise "No `responder` configured for `goldcrest_http_server`"
      _responder -> :ok
    end
  end

  def child_spec(init_args) do
    %{
      id: __MODULE__,
      start: {
        Task,
        :start_link,
        [fn -> apply(__MODULE__, :start, init_args) end]
      }
    }
  end

  def listen(sock) do
    {:ok, req} = :gen_tcp.accept(sock)

    {
      :ok,
      {_http_req, method, {_type, path}, _v}
    } = :gen_tcp.recv(req, 0)

    Logger.info("Received HTTP request #{method} at #{path}")

    spawn(__MODULE__, :respond, [req, method, path])

    listen(sock)
  end

  def respond(req, method, path) do
    %Goldcrest.HTTPResponse{} = resp = responder().resp(req, method, path)
    resp_string = Goldcrest.HTTPResponse.to_string(resp)

    :gen_tcp.send(req, resp_string)

    Logger.info("Response sent: \n#{resp_string}")

    :gen_tcp.close(req)
  end

  defp responder do
    Application.get_env(:goldcrest_http_server, :responder)
  end
end
