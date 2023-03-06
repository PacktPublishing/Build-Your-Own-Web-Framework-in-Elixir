defmodule BehaviorInjector do
  defmacro __before_compile__(_env) do
    quote do
      def hello, do: IO.puts "Hello world!"
    end
  end
end
