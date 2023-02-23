defmodule TasksWeb.RouterTest do
  use Goldcrest.ExUnit.RouterCase

  alias TasksWeb.TaskController

  describe "routes" do
    test "defines GET /tasks routed to TaskController#index" do
      assert_route_defined?(:get, "/tasks", TaskController, :index)
    end

    test "defines GET /tasks/:id/delete routed to TaskController#delete" do
      assert_route_defined?(:get, "/tasks/:id/delete", TaskController, :delete)
    end

    test "defines POST /tasks routed to TaskController#create" do
      assert_route_defined?(:post, "/tasks", TaskController, :create)
    end
  end
end
