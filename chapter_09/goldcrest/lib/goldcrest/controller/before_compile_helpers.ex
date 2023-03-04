defmodule Goldcrest.Controller.BeforeCompileHelpers do
  defmacro __before_compile__(_macro_env) do
    quote do
      def __goldcrest_controller_plugs__, do: @plugs
    end
  end
end
