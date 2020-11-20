defmodule Tetris.Tetromino do
  defstruct shape: :l,
            rotation: 0,
            location: {5, 1}

  alias Tetris.Point
  alias __MODULE__

  @shapes ~w(i t o l j z s a)a

  @spec new(list()) :: %Tetromino{}
  @doc """
  Constructor used for testing, used by the new_random/0
  """
  def new(options \\ []) do
    __struct__(options)
  end

  @spec new_random :: %Tetromino{shape: atom()}
  @doc """
  Returns a new random Tetromino
  """
  def new_random do
    new(shape: random_shape())
  end

  @spec right(%{location: {number, number}}) :: %{location: {number, number}}
  @doc """
  Moves the tetro one point right on the X axis
  """
  def right(tetro) do
    %{tetro | location: Point.right(tetro.location)}
  end

  @spec left(%{location: {number, number}}) :: %{location: {number, number}}
  @doc """
  Moves the tetro one point left on the X axis
  """
  def left(tetro) do
    %{tetro | location: Point.left(tetro.location)}
  end

  @spec down(%{location: {number, number}}) :: %{location: {number, number}}
  @doc """
  Moves the tetro one point down the Y axis
  """
  def down(tetro) do
    %{tetro | location: Point.down(tetro.location)}
  end

  @spec rotate(%{rotation: number}) :: %{rotation: number}
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
