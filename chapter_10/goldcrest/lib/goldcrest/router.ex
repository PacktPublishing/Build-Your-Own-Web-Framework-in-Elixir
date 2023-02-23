defmodule Goldcrest.Router do
  import Plug.Conn

  defmacro __using__(opts) do
    caller = __CALLER__.module

    quote location: :keep do
      use Plug.Router
      import Plug.Router, except: [get: 3, post: 3, put: 3, patch: 3, delete: 3]
      import unquote(__MODULE__)

      @before_compile unquote(__MODULE__).BeforeCompileHelpers

      @opts unquote(opts)

      def __goldcrest_router_using_options__, do: @opts

      Module.register_attribute(__MODULE__, :__routes__, accumulate: true)

      plug(Plug.Parsers, @opts[:parser_options])

      plug(:parse_body)
      plug(:match)
      plug(:dispatch)

      def parse_body(conn, _opts) do
        {:ok, body, conn} = read_body(conn, length: 1_000_000)

        body_params = decode_body_params(body)
        params = Map.merge(conn.params, body_params)
        conn = %{conn | body_params: body_params, params: params}

        conn
      end

      defp decode_body_params(""), do: %{}
      defp decode_body_params(binary), do: Jason.decode!(binary)

      defmodule Helpers do
        use Goldcrest.Router.Helpers, router: unquote(caller)
      end
    end
  end

  defmacro get(path, controller, action) do
    quote location: :keep do
      Module.put_attribute(
        __MODULE__,
        :__routes__,
        {{:get, unquote(path)}, {unquote(controller), unquote(action)}}
      )

      Plug.Router.get(
        unquote(path),
        to: unquote(controller),
        init_opts: [
          action: unquote(action)
        ]
      )
    end
  end

  defmacro post(path, controller, action) do
    quote location: :keep do
      Module.put_attribute(
        __MODULE__,
        :__routes__,
        {{:post, unquote(path)}, {unquote(controller), unquote(action)}}
      )

      Plug.Router.post(
        unquote(path),
        to: unquote(controller),
        init_opts: [
          action: unquote(action)
        ]
      )
    end
  end
end
