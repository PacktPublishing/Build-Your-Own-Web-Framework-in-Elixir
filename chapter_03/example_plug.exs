Mix.install([
  {:plug_cowboy, "~> 2.0"}
])

defmodule GreeterPlug do
  @moduledoc """
  This plug greets the world based on the given greeting
  """

  import Plug.Conn

  @doc """
  Validates options.

  Ensures a greeting is present
  """
  def init(options) do
    greeting = Keyword.get(options, :greeting, "Hello")
    [greeting: greeting]
  end

  @doc """
  Returns a conn with a greeting response
  """
  def call(conn, greeting: greeting) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "#{greeting} World!")
  end
end

%{start: {mod, fun, args}} =
  Plug.Cowboy.child_spec(
    scheme: :http,
    plug: GreeterPlug,
    options: [port: 4040]
  )

apply(mod, fun, args)
IO.puts "Listening on port 4040"

# Run this server for 10 seconds
:timer.sleep(10_000)
