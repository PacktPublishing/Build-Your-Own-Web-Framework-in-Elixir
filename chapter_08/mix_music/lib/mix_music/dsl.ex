defmodule MixMusic.DSL do
  @moduledoc """
  DSL to compose music in Elixir
  """

  defmacro __using__(_) do
    quote do
      @before_compile unquote(__MODULE__)

      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :sequences, accumulate: true)

      def play(sequence_name) do
        play_sequence(__MODULE__, sequence_name)
      end
    end
  end

  defmacro sequence(sequence_name, do: block) do
    quote do
      Module.register_attribute(__MODULE__, :current_sequence, accumulate: true)

      unquote(block)
      @sequences {unquote(sequence_name), @current_sequence |> Enum.reverse()}

      Module.delete_attribute(__MODULE__, :current_sequence)
    end
  end

  defmacro note(class, options) do
    quote do
      if @current_sequence do
        @current_sequence note_from_options(unquote(class), unquote(options))
      else
        raise "note can only be called inside a sequence"
      end
    end
  end

  defmacro embed_notes(sequence_name) do
    quote do
      if @current_sequence do
        notes = notes_from_sequence(__MODULE__, unquote(sequence_name))

        for note <- notes do
          @current_sequence note
        end
      else
        raise "embed_notes can only be called inside a sequence"
      end
    end
  end

  def notes_from_sequence(mod, sequence_name) do
    mod
    |> Module.get_attribute(:sequences)
    |> Keyword.get(sequence_name)
  end

  def note_from_options(class, options) do
    params =
      options
      |> Keyword.put(:class, class)
      |> Enum.into(%{})

    struct!(MixMusic.Note, params)
  end

  defmacro __before_compile__(_) do
    quote do
      def __sequences__, do: @sequences
    end
  end

  def play_sequence(mod, sequence_name) do
    case Keyword.get(mod.__sequences__, sequence_name) do
      nil -> raise "sequence #{sequence_name} not defined"
      notes -> Enum.each(notes, &MixMusic.NotePlayer.play/1)
    end
  end
end
