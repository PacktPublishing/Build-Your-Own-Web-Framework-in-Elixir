defmodule BehaviorInjector do
  defmacro __using__(_options) do
    quote do
      def hello, do: IO.puts "Hello world!"
    end
  end
end
