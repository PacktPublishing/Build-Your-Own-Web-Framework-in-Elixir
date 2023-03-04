defmodule ModuleB do
  require EEx

  EEx.function_from_file(:def, :fun_b, "assigns.eex", [:assigns])
end
