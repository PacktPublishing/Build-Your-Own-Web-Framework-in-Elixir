defmodule ModuleC do
  require EEx

  Code.require_file("custom_engine.ex")

  EEx.function_from_file(
    :def,
    :fun_c,
    "custom_ast.eex",
    [:a, :b],
    engine: CustomEngine
  )
end
