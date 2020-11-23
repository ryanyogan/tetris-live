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

  defp play(socket) do
    socket
    |> push_redirect(to: "/game/playing")
  end

  @impl true
  def handle_event("play", _event, socket) do
    {:noreply, play(socket)}
  end
end
