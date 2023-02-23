defmodule TasksWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        [
          plug: TasksWeb.Router,
          port: 4040,
          scheme: :http,
          options: []
        ]
      },
      {
        TasksWeb.Tasks,
        []
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TasksWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
