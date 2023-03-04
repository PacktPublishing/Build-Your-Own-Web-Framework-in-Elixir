defmodule TasksWeb.Router do
  use Plug.Router

  alias TasksWeb.TaskController

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["text/html", "application/*"]
  )

  plug(:parse_body)
  plug(:match)
  plug(:dispatch)

  get("/tasks/:id/delete", do: TaskController.call(conn, action: :delete))
  get("/tasks", do: TaskController.call(conn, action: :index))
  post("/tasks", do: TaskController.call(conn, action: :create))

  match _ do
    send_resp(conn, 404, "<h1>Not Found</h1>")
  end

  defp parse_body(conn, _opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)

    body_params = decode_body_params(body)
    params = Map.merge(conn.params, body_params)
    conn = %{conn | body_params: body_params, params: params}

    conn
  end

  defp decode_body_params(""), do: %{}
  defp decode_body_params(binary), do: Jason.decode!(binary)
end
