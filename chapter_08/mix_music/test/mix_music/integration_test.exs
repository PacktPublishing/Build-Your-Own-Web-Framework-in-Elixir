defmodule MixMusic.DoReMi do
  use MixMusic.DSL

  sequence :do_re_mi do
    note(:c, octet: 4, volume: 50, duration: 0.25)
    note(:d, modifier: :base, duration: 0.25)
    note(:e, modifier: :base, duration: 0.25)
  end

  sequence :fa_so_la_ti_do do
    note(:f, octet: 4, volume: 50, duration: 0.25)
    note(:g, modifier: :base, duration: 0.25)
    note(:a, duration: 0.25)
    note(:b, duration: 0.25)
    note(:c, octet: 5, duration: 0.25)
  end

  sequence :song do
    embed_notes(:do_re_mi)
    embed_notes(:fa_so_la_ti_do)
  end
end

defmodule MixMusic.IntegrationTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  describe "DoReMi.play/1" do
    test "plays the song (not testing alsa)" do
      output = capture_log(fn -> MixMusic.DoReMi.play(:song) end)

      assert output =~ "Played Note: c base 4"
      assert output =~ "Played Note: d base 4"
      assert output =~ "Played Note: e base 4"
      assert output =~ "Played Note: f base 4"
      assert output =~ "Played Note: g base 4"
      assert output =~ "Played Note: a base 4"
      assert output =~ "Played Note: b base 4"
      assert output =~ "Played Note: c base 5"
    end
  end
end
