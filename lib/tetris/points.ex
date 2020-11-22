defmodule Tetris.Points do
  alias Tetris.Point

  @spec move([{number(), number()}], {number(), number()}) :: [{number(), number()}]
  @doc """
  Move will take a list of tuples which represents all the current
  shape points, the second value is a tuple of points in which we will
  add to the current points, thus creating movement of Tetromino blocks.
  """
  def move(points, change) do
    points
    |> Enum.map(&Point.move(&1, change))
  end

  @spec add_shape([{number(), number()}], atom) :: [{number, number, atom}]
  @doc """
  Add shape takes a series of points, and a shape and will reduce down
  through the points, adding a shape to each tuple as the return value.
  """
  def add_shape(points, shape) do
    points
    |> Enum.map(&Point.add_shape(&1, shape))
  end

  @spec rotate([{number, number}], 0 | 90 | 180 | 270) :: [{number, number}]
  @doc """
  Rotate will patern match on the desired degrees, based on the degrees to rotate
  a reducder will match and flip/mirror/transpose as needed.
  """
  def rotate(points, degrees) do
    points
    |> Enum.map(&Point.rotate(&1, degrees))
  end
end
