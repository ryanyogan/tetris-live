defmodule TetrisWeb.GameLive.Playing do
  use TetrisWeb, :live_view

  alias Tetris.Game

  @rotate_keys ["ArrowUp", " "]

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {:ok, new_game(socket)}
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
    <%= for {x, y, shape} <- @game.points ++ Game.junkyard_points(@game) do %>
      <rect
       width="20" height="20"
       x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>"
       style="fill:<%= color(shape) %>;" />
    <% end %>
    """
  end

  defp color(:l), do: "red"
  defp color(:j), do: "royalblue"
  defp color(:s), do: "limegreen"
  defp color(:z), do: "yellow"
  defp color(:o), do: "magenta"
  defp color(:i), do: "silver"
  defp color(:t), do: "saddlebrown"
  defp color(_shape), do: "red"

  def new_game(socket) do
    assign(socket, game: Game.new())
  end

  def rotate(%{assigns: %{game: game}} = socket) do
    assign(
      socket,
      game: Game.rotate(game)
    )
  end

  def left(%{assigns: %{game: game}} = socket) do
    assign(
      socket,
      game: Game.left(game)
    )
  end

  def right(%{assigns: %{game: game}} = socket) do
    assign(
      socket,
      game: Game.right(game)
    )
  end

  @spec down(Phoenix.LiveView.Socket.t()) :: Phoenix.LiveView.Socket.t()
  @doc """
  Takes the tetromino and moves it down the Y axis one
  value
  """
  def down(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.down(game))
  end

  def maybe_end_game(%{assigns: %{game: %{game_over: true}}} = socket) do
    socket
    |> push_redirect(to: "/game/over?score=#{socket.assigns.game.score}")
  end

  def maybe_end_game(_game_not_over = socket), do: socket

  @impl true
  @spec handle_info(:tick, Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info(:tick, socket) do
    {
      :noreply,
      socket
      |> down()
      |> maybe_end_game()
    }
  end

  @impl true
  def handle_event("keystroke", %{"key" => key}, socket) when key in @rotate_keys do
    {:noreply, socket |> rotate()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> right()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> left()}
  end

  @impl true
  def handle_event("keystroke", _not_captured, socket), do: {:noreply, socket}
end
