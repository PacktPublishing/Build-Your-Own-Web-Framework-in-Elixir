defmodule ExampleServerHtmlEex.MixProject do
  use Mix.Project

  def project do
    [
      app: :example_server_html_eex,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ExampleServerHtmlEex.Application, []}
    ]
  end

  defp deps do
    [
      {:goldcrest, path: "../goldcrest"},
      {:floki, ">= 0.0.0", only: :test}
    ]
  end
end
