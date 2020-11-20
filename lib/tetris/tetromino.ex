defmodule Tetris.Tetromino do
  defstruct shape: :l,
            rotation: 0,
            location: {5, 1}

  alias Tetris.Point

  @shapes ~w(i t o l j z s a)a
  @doc """
  Constructor used for testing, used by the new_random/0
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

  @doc """
  Moves the tetro one point right on the X axis
  """
  def right(tetro) do
    %{tetro | location: Point.right(tetro.location)}
  end

  @doc """
  Moves the tetro one point left on the X axis
  """
  def left(tetro) do
    %{tetro | location: Point.left(tetro.location)}
  end

  @doc """
  Moves the tetro one point down the Y axis
  """
  def down(tetro) do
    %{tetro | location: Point.down(tetro.location)}
  end

  @doc """
  Rotate the tetro based on degrees. This will call rotate_degrees/1 which
  will rotate in increments to the right of 90, 180, 270, and back to 0 (true north).
  """
  def rotate(tetro) do
    %{tetro | rotation: rotate_degrees(tetro.rotation)}
  end

  defp rotate_degrees(270) do
    0
  end

  defp rotate_degrees(n) do
    n + 90
  end

  defp random_shape do
    @shapes
    |> Enum.random()
  end
end
