defmodule Goldcrest.Controller do
  import Plug.Conn

  defmacro __using__(opts) do
    quote do
      use Plug.Builder
      import Plug.Conn

      import Goldcrest.ResponseHelpers, except: [render: 3]

      @opts unquote(opts)

      @default_view_module __MODULE__
                           |> Module.split()
                           |> List.update_at(-1, fn str ->
                             String.replace(str, "Controller", "View")
                           end)
                           |> Module.concat()

      @view_module @opts[:view_module] || @default_view_module

      def render(conn, file, assigns) do
        @view_module.render(conn, file, assigns)
      end

      def __goldcrest_controller_using_options__, do: @opts

      def __goldcrest_controller_view_module__, do: @view_module

      @before_compile Goldcrest.Controller.BeforeCompileHelpers

      def call(conn, action: action) do
        conn = super(conn, [])

        apply(__MODULE__, action, [conn, conn.params])
      end
    end
  end
end
