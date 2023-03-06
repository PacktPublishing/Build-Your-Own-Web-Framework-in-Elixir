defmodule BehaviorInjector do
  def behaviour_quoted_expr do
    quote do
      def hello, do: IO.puts "Hello world!"
    end
  end
end
