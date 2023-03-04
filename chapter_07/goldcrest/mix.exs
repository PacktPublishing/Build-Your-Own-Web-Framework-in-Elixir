defmodule Goldcrest.MixProject do
  use Mix.Project

  def project do
    [
      app: :goldcrest,
      version: "0.1.0",
      elixir: "~> 1.12",
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
    [
      {:jason, "~> 1.2.2"},
      {:plug_cowboy, ">= 0.0.0"}
      # {:plug_goldcrest_http_server, path: "../plug_goldcrest_http_server"}
    ]
  end
end
