defmodule TasksWeb.TaskController do
  use Plug.Builder
  import Plug.Conn
  alias TasksWeb.Tasks

  def call(conn, action: action) do
    conn = super(conn, [])

    apply(__MODULE__, action, [conn, conn.params])
  end

  def index(conn, _params) do
    tasks = Tasks.list()

    conn
    |> put_status(200)
    |> render("tasks.html.eex", tasks: tasks)
  end

  def create(conn, %{"name" => name, "description" => description}) do
    Tasks.add(name, description)

    conn
    |> Goldcrest.Controller.redirect(to: "/tasks")
  end

  def delete(conn, %{"id" => id}) do
    id
    |> String.to_integer()
    |> Tasks.delete()

    conn
    |> Goldcrest.Controller.redirect(to: "/tasks")
  end

  defp render(conn, file, assigns) do
    TasksWeb.TaskView.render(conn, file, assigns)
  end
end
