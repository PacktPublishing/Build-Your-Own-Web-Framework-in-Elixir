defmodule TasksWeb.TaskControllerTest do
  use Goldcrest.ExUnit.ControllerCase

  alias TasksWeb.Tasks

  setup do
    clear_store()

    :ok
  end

  describe "GET /tasks -- index/2" do
    setup do
      name = "Test Name"
      description = "Test Description"
      Tasks.add(name, description)

      {:ok, name: name, description: description}
    end

    test "renders a list of tasks", %{name: name, description: description} do
      conn = get("/tasks")

      assert conn.resp_body =~ "Listing Tasks"

      stringified_task = TasksWeb.TaskView.stringify_task({name, description})
      assert conn.resp_body =~ stringified_task
    end
  end

  describe "POST /tasks -- create/2" do
    test "creates a new task and redirects to index" do
      name = "Test Name"
      description = "Test Description"

      stringified_task = TasksWeb.TaskView.stringify_task({name, description})

      # Task doesn't exist at first
      conn = get("/tasks")
      assert conn.resp_body =~ "Listing Tasks"
      refute conn.resp_body =~ stringified_task

      conn = post("/tasks", %{name: name, description: description})

      # Redirects to index
      assert conn.status == 302
      assert {"location", "/tasks"} in conn.resp_headers

      # Task exists on the index page
      conn = get("/tasks")
      assert conn.resp_body =~ stringified_task
    end
  end

  describe "GET /tasks/:id -- delete/2" do
    setup do
      name = "Test Name"
      description = "Test Description"
      Tasks.add(name, description)

      {:ok, name: name, description: description}
    end

    test "deletes the task", %{name: name, description: description} do
      conn = get("/tasks")

      assert conn.resp_body =~ "Listing Tasks"

      # Task appears in the list at first
      stringified_task = TasksWeb.TaskView.stringify_task({name, description})
      assert conn.resp_body =~ stringified_task

      conn = get("/tasks/1/delete")

      # Redirects to index
      assert conn.status == 302
      assert {"location", "/tasks"} in conn.resp_headers

      conn = get("/tasks")

      # Task doesn't appear in the list
      stringified_task = TasksWeb.TaskView.stringify_task({name, description})
      assert conn.resp_body =~ stringified_task
    end
  end

  defp clear_store do
    Agent.update(TasksWeb.Tasks, fn _ -> [] end)
  end
end
