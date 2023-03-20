defmodule Goldcrest.ExampleRouter do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:html],
    pass:  ["text/html"]

  plug(:match)
  plug(:dispatch)

  get "/greet" do
    Goldcrest.ExampleController.call(conn, action: :greet)
  end

  get "/redirect_greet" do
    Goldcrest.ExampleController.call(conn, action: :redirect_greet)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
