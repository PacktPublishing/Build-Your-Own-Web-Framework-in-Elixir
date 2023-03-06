defmodule TestAfterCompile do
  @after_compile __MODULE__

  def __after_compile__(_env, _bytecode) do
    IO.puts "Compiled #{__MODULE__}"
  end
end
