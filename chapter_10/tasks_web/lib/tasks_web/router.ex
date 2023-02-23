defmodule TasksWeb.Router do
  use Goldcrest.Router,
    parser_options: [
      parsers: [:urlencoded, :multipart],
      pass: ["text/html", "application/*"]
    ]

  alias TasksWeb.TaskController

  get("/tasks/:id/delete", TaskController, :delete)
  get("/tasks", TaskController, :index)
  post("/tasks", TaskController, :create)
end
