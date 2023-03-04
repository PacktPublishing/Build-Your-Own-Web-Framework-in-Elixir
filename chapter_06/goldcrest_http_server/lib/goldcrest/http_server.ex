defmodule Goldcrest.HTTPServer do
  require Logger

  @server_options [
    active: false,
    packet: :http_bin,
    reuseaddr: true
  ]

  def start(port) do
    case :gen_tcp.listen(port, @server_options) do
      {:ok, sock} ->
        Logger.info("Started a webserver on port #{port}")

        listen(sock)

      {:error, error} ->
        Logger.error("Cannot start server on port #{port}: #{error}")
    end
  end

  def listen(sock) do
    {:ok, req} = :gen_tcp.accept(sock)
    recv_resp = :gen_tcp.recv(req, 0)

    {:ok, {_http_req, method, {_type, path}, _v}} = recv_resp

    Logger.info("Received HTTP request #{method} at #{path}")

    dispatch(req, method, path)

    listen(sock)
  end

  defp dispatch(req, method, path) do
    case dispatcher() do
      {mod, opts} ->
        mod.init(req, method, path, opts)

      mod ->
        mod.init(req, method, path, [])
    end
  end

  defp dispatcher do
    Application.get_env(:goldcrest_http_server, :dispatcher)
  end

  def respond(req, method, path) do
    # This part is different for different applications

    resp_string = "Hello World"

    :gen_tcp.send(req, resp_string)

    Logger.info("Response sent: \n#{resp_string}")

    :gen_tcp.close(req)
  end
end
