defmodule Tetris.Game do
  defstruct [:tetro, points: [], score: 0, junkyard: %{}]

  alias Tetris.{Tetromino, Points}

  def new() do
    __struct__()
    |> new_tetromino()
    |> show()
  end

  def move(%{tetro: tetro} = game, move_fn) do
    current_postion = tetro

    new_position =
      tetro
      |> move_fn.()

    valid_move? =
      new_position
      |> Tetromino.show()
      |> Points.valid?()

    moved = Tetromino.maybe_move(current_postion, new_position, valid_move?)

    %{game | tetro: moved}
    |> show()
  end

  def down(game), do: game |> move(&Tetromino.down/1)
  def right(game), do: game |> move(&Tetromino.right/1)
  def left(game), do: game |> move(&Tetromino.left/1)
  def rotate(game), do: game |> move(&Tetromino.rotate/1)

  def new_tetromino(game) do
    %{game | tetro: Tetromino.new_random()}
    |> show()
  end

  def show(game) do
    %{game | points: Tetromino.show(game.tetro)}
  end
end
