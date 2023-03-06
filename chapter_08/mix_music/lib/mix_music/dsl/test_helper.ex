defmodule MixMusic.DSL.TestHelper do
  @moduledoc """
  Test helpers for MixMusic.DSL
  """
  def defines_sequence?(module, sequence_name, with_notes: notes) do
    actual_notes =
      module.__sequences__()
      |> Keyword.get(sequence_name)

    notes == actual_notes
  end

  def sequence_note(class, options) do
    MixMusic.DSL.note_from_options(class, options)
  end
end
