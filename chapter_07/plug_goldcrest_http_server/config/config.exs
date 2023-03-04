import Config

config :goldcrest_http_server,
  dispatcher: {
    Plug.Goldcrest.HTTPServer,
    [
      plug: ExampleRouter,
      options: []
    ]
  }
