defmodule Goldcrest.Router.BeforeCompileHelpers do
  defmacro __before_compile__(_macro_env) do
    quote do
      defp do_match(conn, _, _, _) do
        conn = send_resp(conn, 404, "<h1>Not Found</h1>")

        Plug.Router.__put_route__(conn, conn.request_path, fn conn, _ ->
          conn
        end)
      end

      def __goldcrest_router_routes__, do: @__routes__
    end
  end
end
