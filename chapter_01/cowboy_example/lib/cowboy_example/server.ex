defmodule CowboyExample.Server do
  @moduledoc """
  This module defines a cowboy HTTP server and starts it
  on a port
  """

  @doc """
  This function starts a Cowboy server on the given port.

  Routes for the server are defined in CowboyExample.Router
  """
  def start(port) do
    routes = CowboyExample.Router.routes()

    dispatch_rules = :cowboy_router.compile(routes)

    {:ok, _pid} =
      :cowboy.start_clear(
        :listener,
        [{:port, port}],
        %{env: %{dispatch: dispatch_rules}}
      )
  end
end
