defmodule ModuleA do
  require EEx

  EEx.function_from_file(:def, :fun_a, "function_body.eex", [:a, :b])
end
