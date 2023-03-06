Code.require_file("test/support/mix_music/dsl/tester.ex")

defmodule MixMusic.DSL.TestHelperTest do
  use ExUnit.Case

  import MixMusic.DSL.TestHelper

  describe "test DSL" do
    test "defines do_re_mi with correct notes" do
      assert defines_sequence?(
               MixMusic.DSLTester,
               :do_re_mi,
               with_notes: [
                 sequence_note(:c, octet: 4, volume: 50, duration: 0.25),
                 sequence_note(:d, modifier: :base, duration: 0.25),
                 sequence_note(:e, modifier: :base, duration: 0.25)
               ]
             )
    end
  end
end
