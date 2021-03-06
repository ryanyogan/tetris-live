defmodule Tetris.Tetromino do
  defstruct shape: :l,
            rotation: 0,
            location: {3, -4}

  alias Tetris.{Point, Points}
  alias __MODULE__

  @type t(shape, rotation, location) ::
          %Tetromino{shape: shape, rotation: rotation, location: location}

  @type t :: %Tetromino{shape: atom(), rotation: number(), location: tuple()}

  @shapes ~w(i t o l j z s)a

  @spec new(list()) :: %Tetromino{}
  @doc """
  Constructor used for testing, used by the new_random/0
  """
  def new(options \\ []) do
    __struct__(options)
  end

  @spec new_random :: Tetromino.t()
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

  def show(tetro) do
    tetro
    |> points()
    |> Points.rotate(tetro.rotation)
    |> Points.move(tetro.location)
    |> Points.add_shape(tetro.shape)
  end

  def points(%{shape: :l} = _tetro) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :j} = _tetro) do
    [
      {3, 1},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :i} = _tetro) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end

  def points(%{shape: :o} = _tetro) do
    [
      {2, 2},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :s} = _tetro) do
    [
      {2, 2},
      {3, 2},
      {1, 3},
      {2, 3}
    ]
  end

  def points(%{shape: :z} = _tetro) do
    [
      {1, 2},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :t} = _tetro) do
    [
      {1, 2},
      {2, 2},
      {3, 2},
      {2, 3}
    ]
  end

  def maybe_move(_old, new, _valid = true), do: new
  def maybe_move(old, _new, _valid = false), do: old

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
