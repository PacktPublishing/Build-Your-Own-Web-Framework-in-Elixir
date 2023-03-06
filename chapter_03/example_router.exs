Mix.install([
  {:plug_cowboy, "~> 2.0"}
])

defmodule ExampleRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/greet" do
    send_resp(conn, 200, "Hello World")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end

%{start: {mod, fun, args}} =
  Plug.Cowboy.child_spec(
    scheme: :http,
    plug: ExampleRouter,
    options: [port: 4040]
  )

apply(mod, fun, args)
IO.puts "Listening on port 4040"

# Run this server for 10 seconds
:timer.sleep(10_000)
