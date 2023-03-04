defmodule Goldcrest.ExampleRouter do
  # import Goldcrest.Router

  use Plug.Router

  plug :match
  plug :dispatch

  # goldcrest_get(conn, "/greet", to: {Goldcrest.ExampleController, :greet})
  get "/greet", do: Goldcrest.ExampleController.call(conn, action: :greet)

  get "/redirect_greet" do
    Goldcrest.ExampleController.call(conn, action: :redirect_greet)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
