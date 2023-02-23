defmodule ExampleServerHtmlEex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Goldcrest.HTTPServer,
        [
          plug: ExampleServerHtmlEex.Router,
          port: 4040,
          options: []
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: ExampleServerHtmlEex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
