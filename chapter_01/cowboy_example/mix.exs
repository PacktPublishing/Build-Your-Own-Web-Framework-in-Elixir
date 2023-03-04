defmodule CowboyExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :cowboy_example,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CowboyExample.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.8"},
      {:finch, "~> 0.6"}
    ]
  end
end
