defmodule TetrisWeb.GameLive.GameOver do
  use TetrisWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    {
      :ok,
      assign(socket, score: params["score"])
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
