defmodule Goldcrest.ExUnit.ControllerCase do
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case
      use Plug.Test

      @opts unquote(opts)

      @default_router_module __MODULE__
                             |> Module.split()
                             |> Enum.take(1)
                             |> List.insert_at(1, ".Router")
                             |> Module.concat()

      @router_module @opts[:router] || @default_router_module

      @helper_module unquote(__MODULE__)

      def get(path, params_or_body \\ nil) do
        @helper_module.request(:get, path, params_or_body, @router_module)
      end

      def post(path, params_or_body \\ nil) do
        @helper_module.request(:post, path, params_or_body, @router_module)
      end

      def put(path, params_or_body \\ nil) do
        @helper_module.request(:put, path, params_or_body, @router_module)
      end

      def patch(path, params_or_body \\ nil) do
        @helper_module.request(:patch, path, params_or_body, @router_module)
      end

      def delete(path, params_or_body \\ nil) do
        @helper_module.request(:delete, path, params_or_body, @router_module)
      end
    end
  end

  def request(method, path, params_or_body \\ nil, router)

  def request(method, path, params, router) when is_map(params) do
    request(method, path, Jason.encode!(params), router)
  end

  def request(method, path, params_or_body, router) do
    conn = Plug.Test.conn(method, path, params_or_body)

    router.call(conn, [])
  end
end
