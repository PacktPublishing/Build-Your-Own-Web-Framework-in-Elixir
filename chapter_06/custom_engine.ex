defmodule CustomEngine do
  @behaviour EEx.Engine

  @impl true
  defdelegate init(opts), to: EEx.Engine

  @impl true
  defdelegate handle_body(state), to: EEx.Engine

  @impl true
  defdelegate handle_begin(state), to: EEx.Engine

  @impl true
  defdelegate handle_end(state), to: EEx.Engine

  @impl true
  defdelegate handle_text(state, meta, text), to: EEx.Engine

  @impl true
  def handle_expr(state, "|", expr) do
    expr =
      quote do
        IO.inspect(unquote(expr))
      end

    handle_expr(state, "", expr)
  end

  def handle_expr(state, marker, expr) do
    EEx.SmartEngine.handle_expr(state, marker, expr)
  end
end
