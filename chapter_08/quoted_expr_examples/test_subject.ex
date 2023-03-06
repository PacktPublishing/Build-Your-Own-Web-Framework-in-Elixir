defmodule TestSubject do
  Code.eval_quoted(BehaviorInjector.behaviour_quoted_expr(), [], __ENV__)
end
