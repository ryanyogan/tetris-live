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
end
