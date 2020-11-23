defmodule Tetris.Game do
  defstruct [:tetro, points: [], score: 0, junkyard: %{}]

  alias Tetris.{Tetromino, Points}

  def new() do
    __struct__()
    |> new_tetromino()
    |> show()
  end

  def move(game, move_fn) do
    {old, new, valid?} = move_data(game, move_fn)
    moved = Tetromino.maybe_move(old, new, valid?)

    %{game | tetro: moved}
    |> show()
  end

  defp move_data(%{tetro: tetro} = game, move_fn) do
    current_postion = tetro

    new_position =
      tetro
      |> move_fn.()

    valid_move? =
      new_position
      |> Tetromino.show()
      |> Points.valid?(game.junkyard)

    {current_postion, new_position, valid_move?}
  end

  def down(game) do
    {old, new, valid?} = move_data(game, &Tetromino.down/1)

    move_down_or_merge(game, old, new, valid?)
  end

  def move_down_or_merge(game, _old, new, true = _valid) do
    %{game | tetro: new}
    |> show()
    |> inc_score(1)
  end

  def move_down_or_merge(game, old, _new, false = _valid) do
    game
    |> merge(old)
    |> new_tetromino()
    |> show()
  end

  def merge(game, old) do
    new_junkyard =
      old
      |> Tetromino.show()
      |> Enum.map(fn {x, y, shape} -> {{x, y}, shape} end)
      |> Enum.into(game.junkyard)

    %{game | junkyard: new_junkyard}
  end

  def junkyard_points(game) do
    game.junkyard
    |> Enum.map(fn {{x, y}, shape} -> {x, y, shape} end)
  end

  def right(game), do: game |> move(&Tetromino.right/1)
  def left(game), do: game |> move(&Tetromino.left/1)
  def rotate(game), do: game |> move(&Tetromino.rotate/1)

  def new_tetromino(game) do
    %{game | tetro: Tetromino.new_random()}
  end

  def show(game) do
    %{game | points: Tetromino.show(game.tetro)}
  end

  def inc_score(game, value) do
    %{game | score: game.score + value}
  end
end
