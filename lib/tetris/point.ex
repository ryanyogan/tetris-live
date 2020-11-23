defmodule Tetris.Point do
  @moduledoc """
  A point represents the points on a Tetris board, the
  board is 10 * 20 points.  10 being the x-axis value, and 20
  being the y-axis value.
  """
  @spec origin :: {0, 0}
  @doc """
  Constructor function, returns a tuple with {0, 0}
  """
  def origin() do
    {0, 0}
  end

  @spec left({number, number}) :: {number, number}
  @doc """
  Returns a tuple with the x value -1 (left)
  """
  def left({x, y}) do
    {x - 1, y}
  end

  @spec right({number, number}) :: {number, number}
  @doc """
  Returns a tuple with the x value +1 (right)
  """
  def right({x, y}) do
    {x + 1, y}
  end

  @spec down({number, number}) :: {number, number}
  @doc """
  Returns a tuple with the y value +1 (down)
  """
  def down({x, y}) do
    {x, y + 1}
  end

  @spec move({number, number}, {number, number}) :: {number, number}
  @doc """
  Move takes the current x and y position, along with the delta (change)
  and returns a new tuple representing the new points for a block to fill.
  """
  def move({x, y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end

  @spec transpose(tuple()) :: {number, number}
  @doc """
  Transpose takes an x and y point, and returns them reverse in a tuple. This
  is a basic transpose for a 4x4 grid (all Tetromino's are within 4x4 cells)
  """
  def transpose({x, y}) do
    {y, x}
  end

  @spec mirror(tuple()) :: {number, number}
  @doc """
  Mirror takes an x and y point, and adds 5 to the x value, thus creating a
  mirror on the x-axis.
  """
  def mirror({x, y}) do
    {5 - x, y}
  end

  @spec flip({number, number}) :: {number, number}
  @doc """
  Flip takes an x and y point, and subtracts y from  5 the y value, thus creating a
  flip on the x-axis.
  """
  def flip({x, y}) do
    {x, 5 - y}
  end

  @spec rotate({number(), number()}, 0 | 90 | 180 | 270) :: {number(), number()}
  @doc """
  Rotate will take a tuple of points, and call the required transformation functions
  to move the points to acheive the desired rotation in degrees.

  In the game of tetris you may only rotate in 90 degree segments [0, 90, 180, 270]
  """
  def rotate(points, 0) do
    points
  end

  def rotate(points, 90) do
    points |> flip() |> transpose()
  end

  def rotate(points, 180) do
    points |> mirror() |> flip()
  end

  def rotate(points, 270) do
    points |> mirror() |> transpose()
  end

  @doc """
  Takes a point tuple, with a shape as a paramenter and merges them into
  one single tuple for the UI.
  """
  def add_shape({x, y}, shape) do
    {x, y, shape}
  end

  def add_shape(point_with_shape, _shape) do
    point_with_shape
  end

  def in_bounds?({x, y, _c}), do: in_bounds?({x, y})

  def in_bounds?({x, _y}) when x < 1, do: false
  def in_bounds?({x, _y}) when x > 10, do: false
  def in_bounds?({_x, y}) when y > 20, do: false
  def in_bounds?(_points_in_bounds), do: true
end
