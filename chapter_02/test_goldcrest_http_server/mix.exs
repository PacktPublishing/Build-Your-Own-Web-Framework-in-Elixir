defmodule TestGoldcrestHttpServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :test_goldcrest_http_server,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TestGoldcrestHttpServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:goldcrest_http_server, path: "../goldcrest_http_server"}
    ]
  end
end
