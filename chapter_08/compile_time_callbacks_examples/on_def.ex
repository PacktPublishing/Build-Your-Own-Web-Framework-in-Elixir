defmodule TestOnDef do
  def __on_definition__(_, _, name, _, _, body) do
    IO.puts """
    Defining a function named #{name}
    with body:
    #{Macro.to_string(body)}
    """
  end
end
