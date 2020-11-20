defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {5, 1}

  @shapes ~w(i t o l j z s a)a
  @doc """
  Constructor used for testing, and the new_random/0
  """
  def new(options \\ []) do
    __struct__(options)
  end

  @doc """
  Returns a new random Tetromino
  """
  def new_random do
    new(shape: random_shape())
  end

  # Private Interfaces

  defp random_shape do
    @shapes
    |> Enum.random()
  end
end
