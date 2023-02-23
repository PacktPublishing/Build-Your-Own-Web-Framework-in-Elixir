defmodule TasksWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :tasks_web,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TasksWeb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:goldcrest, path: "../goldcrest"}
    ]
  end
end
