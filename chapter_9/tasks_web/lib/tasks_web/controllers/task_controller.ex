defmodule TasksWeb.TaskController do
  use Goldcrest.Controller

  alias TasksWeb.Tasks

  def index(conn, _params) do
    tasks = Tasks.list()

    conn
    |> put_status(200)
    |> render("tasks.html.eex", tasks: tasks)
  end

  def create(conn, %{"name" => name, "description" => description}) do
    Tasks.add(name, description)

    conn
    |> redirect(to: "/tasks")
  end

  def delete(conn, %{"id" => id}) do
    id
    |> String.to_integer()
    |> Tasks.delete()

    conn
    |> redirect(to: "/tasks")
  end
end
