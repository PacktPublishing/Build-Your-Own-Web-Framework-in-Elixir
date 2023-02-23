defmodule ExampleServerHtmlEex.View do
  def render(conn, file, assigns) do
    Goldcrest.View.render(__MODULE__, conn, file, assigns)
  end
end
