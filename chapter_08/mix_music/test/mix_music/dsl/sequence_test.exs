defmodule QuotedModule.Sequence do
  Module.register_attribute(__MODULE__, :sequences, accumulate: true)

  def sequences_before, do: @sequences

  require MixMusic.DSL

  MixMusic.DSL.sequence :test do
    @current_sequence 5
    @current_sequence 10
  end

  def sequences_after, do: @sequences
end

defmodule MixMusic.DSL.SequenceTest do
  use ExUnit.Case

  describe "sequence/2" do
    test "updates `@sequences`" do
      assert QuotedModule.Sequence.sequences_before() == []
      assert QuotedModule.Sequence.sequences_after() == [test: [5, 10]]
    end
  end
end
