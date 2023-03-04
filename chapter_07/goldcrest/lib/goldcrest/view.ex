defmodule Goldcrest.View do
  require EEx
  alias Goldcrest.Controller

  def render(view_module, conn, file, assigns) do
    contents =
      file
      |> html_file_path()
      |> EEx.eval_file(assigns: assigns)

    Controller.render(conn, :html, contents)
  end

  defp html_file_path(file) do
    templates_path()
    |> Path.join(file)
  end

  defp templates_path do
    Application.fetch_env!(:goldcrest, :templates_path)
  end
end
