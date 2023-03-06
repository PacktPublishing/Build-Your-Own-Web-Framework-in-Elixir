defmodule MixMusic.Note do
  @moduledoc """
  Struct representing a Music Note
  """

  defstruct class: nil, modifier: :base, octet: 4, duration: 0.5, volume: 50

  @a4_frequency 440
  @a4_octet 4
  @a4_index 9
  @frequency_constant 1.059463

  def to_frequency(%__MODULE__{class: :rest}), do: 0

  def to_frequency(%__MODULE__{octet: octet} = note) do
    semitones_from_a4 = 12 * (octet - @a4_octet) - (@a4_index - semitone_index(note))
    relative_frequency = :math.pow(@frequency_constant, semitones_from_a4)
    round(@a4_frequency * relative_frequency)
  end

  defp semitone_index(%__MODULE__{class: class, modifier: modifier}) do
    Enum.find_index(
      semitones(),
      fn {cl, mo} -> class == cl && modifier == mo end
    )
  end

  defp semitones do
    [
      {:c, :base},
      {:c, :sharp},
      {:d, :base},
      {:d, :sharp},
      {:e, :base},
      {:f, :base},
      {:f, :sharp},
      {:g, :base},
      {:g, :sharp},
      {:a, :base},
      {:a, :sharp},
      {:b, :base}
    ]
  end
end
