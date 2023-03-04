import Config

if Mix.env() == :test do
  config :cowboy_example,
    port: 4041

  config :logger, warn: false
end
