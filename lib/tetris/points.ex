defmodule Tetris.Points do
  alias Tetris.Point

  @doc """
  Move will take a list of tuples which represents all the current
  shape points, the second value is a tuple of points in which we will
  add to the current points, thus creating movement of Tetromino blocks.
  """
  def move(points, change) do
    points
    |> Enum.map(&Point.move(&1, change))
  end

  def add_shape(points, shape) do
    points
    |> Enum.map(&Point.add_shape(&1, shape))
  end
end
