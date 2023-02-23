defmodule Goldcrest.Router do
  defmacro goldcrest_get(conn, route, to: {controller, action}) do
    quote do
      get("/greet", do: unquote(controller).call(unquote(conn), action: unquote(action)))
    end
  end
end
