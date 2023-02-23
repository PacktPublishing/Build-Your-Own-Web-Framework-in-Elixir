defmodule Goldcrest.ExUnit.RouterCase do
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case

      @opts unquote(opts)

      @default_router_module __MODULE__
                             |> Module.split()
                             |> Enum.take(1)
                             |> List.insert_at(1, ".Router")
                             |> Module.concat()

      @router_module @opts[:router] || @default_router_module

      @helper_module unquote(__MODULE__)

      def assert_route_defined?(method, match, controller, action) do
        routes = @router_module.__goldcrest_router_routes__()
        expected_route = {{method, match}, {controller, action}}

        ExUnit.Assertions.assert(
          expected_route in routes,
          """
          Expected the following route to be defined in the router, but it was
          not:

          #{@helper_module.humanize_route(expected_route)}.

          Defined routes:
          #{@helper_module.humanize_routes(routes)}
          """
        )
      end
    end
  end

  def humanize_routes(routes) when is_list(routes) do
    routes
    |> Enum.map(&humanize_route/1)
    |> Enum.join("\n")
  end

  def humanize_route({{method, match}, {controller, action}}) do
    "#{inspect(method)} #{match}, #{controller}, #{action}"
  end
end
