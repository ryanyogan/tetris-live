defmodule TetrisWeb.GameLive.GameOver do
  use TetrisWeb, :live_view
  alias Tetris.Game

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, game: Map.get(socket.assigns, :game) || Game.new())
    }
  end
end
