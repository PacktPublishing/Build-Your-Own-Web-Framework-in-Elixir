defmodule MixMusic.DSL.RestrictionsTest do
  use ExUnit.Case

  describe "note/2" do
    test "can only be called inside a sequence" do
      quoted_module =
        quote location: :keep do
          defmodule QuotedModule.Note do
            import MixMusic.DSL

            note(:c, volume: 10)
          end
        end

      assert_raise(RuntimeError, "note can only be called inside a sequence", fn ->
        Code.eval_quoted(quoted_module)
      end)
    end
  end

  describe "embed_notes/2" do
    test "can only be called inside a sequence" do
      quoted_module =
        quote location: :keep do
          defmodule QuotedModule.Note do
            import MixMusic.DSL

            embed_notes(:sequence)
          end
        end

      assert_raise(RuntimeError, "embed_notes can only be called inside a sequence", fn ->
        Code.eval_quoted(quoted_module)
      end)
    end
  end
end
