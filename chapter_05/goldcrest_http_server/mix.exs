defmodule Goldcrest.HTTPServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :goldcrest_http_server,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
