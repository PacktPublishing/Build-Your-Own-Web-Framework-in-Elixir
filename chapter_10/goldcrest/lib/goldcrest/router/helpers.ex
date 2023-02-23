defmodule Goldcrest.Router.Helpers do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      @opts unquote(opts)

      @default_router_module __MODULE__
                             |> Module.split()
                             |> Enum.take(1)
                             |> List.insert_at(1, ".Router")
                             |> Module.concat()

      @router_module @opts[:router] || @default_router_module

      def path(controller, action, bindings \\ []) do
        unquote(__MODULE__).path(
          @router_module,
          controller,
          action,
          bindings
        )
      end
    end
  end

  def path(router, controller, action, bindings \\ []) do
    routes = router.__goldcrest_router_routes__()

    route =
      Enum.find(routes, fn
        {{_action, _path}, {^controller, ^action}} -> true
        _ -> false
      end)

    apply_bindings(route, bindings)
  end

  defp apply_bindings({{_action, path}, {_, _}}, bindings) do
    Enum.reduce(bindings, path, fn {key, value}, acc ->
      String.replace(acc, ":#{key}", to_string(value))
    end)
  end
end
