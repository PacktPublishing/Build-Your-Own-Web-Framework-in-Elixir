defmodule CowboyExample.Router.Handlers.Root do
  @moduledoc """
  This module defines the handler for the root route.
  """

  require Logger

  @doc """
  This function handles the root route, logs the requests and responds
  with Hello World as the body
  """
  def init(%{method: "GET"} = req0, state) do
    Logger.info("Received request: #{inspect(req0)}")

    req1 =
      :cowboy_req.reply(
        200,
        %{"content-type" => "text/html"},
        "Hello World",
        req0
      )

    {:ok, req1, state}
  end

  # General clause for init/2 which responds with 404
  def init(req0, state) do
    Logger.info("Received request: #{inspect(req0)}")

    req1 =
      :cowboy_req.reply(
        404,
        %{"content-type" => "text/html"},
        "404 Not found",
        req0
      )

    {:ok, req1, state}
  end
end
