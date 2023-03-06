Code.require_file("test/support/mix_music/dsl/tester.ex")

defmodule MixMusic.DSLTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  alias MixMusic.{DSL, DSLTester}

  describe "play_sequence/2" do
    test "raises when calling a sequence that's not defined" do
      assert_raise(RuntimeError, ~r/sequence bad_sequence not defined/, fn ->
        DSLTester.play(:bad_sequence)
      end)
    end

    test "plays a sequence when it's defined" do
      output = capture_log(fn -> DSLTester.play(:do_re_mi) end)

      assert output =~ "Played Note: c base 4"
      assert output =~ "Played Note: d base 4"
      assert output =~ "Played Note: e base 4"
    end
  end

  describe "__before_compile__/1" do
    require DSL

    test "defines a function `__sequences__` which delegates to `@sequences`" do
      expected =
        quote do
          def __sequences__, do: @sequences
        end

      expr = quote do: DSL.__before_compile__(nil)
      expanded = Macro.expand_once(expr, __ENV__)

      assert Macro.to_string(expected) == Macro.to_string(expanded)
    end

    test "defines `DSLTester.__sequences__/0`" do
      sequences = Keyword.keys(DSLTester.__sequences__())

      assert :song in sequences
      assert :do_re_mi in sequences
      assert :fa_so_la_ti_do in sequences
    end
  end
end
