defmodule TasksWeb.TaskView do
  use Goldcrest.View

  def stringify_task({name, description}) do
    "#{name} - #{description}"
  end
end
