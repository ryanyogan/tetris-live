defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  alias Tetris.Tetromino

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {
      :ok,
      socket
      |> new_tetromino()
      |> show()
    }
  end

  @impl true
  @spec render(Phoenix.LiveView.Socket.t()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <% [{x, y}] = @points %>
    <section class="phx-hero">
    <h1>Welcome to Tetris</h1>
    <%= render_board(assigns) %>
      <pre>
        {<%= x %>, <%= y %>}
      </pre>
    </section>
    """
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(%{points: [{x, y}]} = assigns) do
    ~L"""
    <rect width="20" height="20" x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" style="fill:rgb(255,0,0);" />
    """
  end

  @spec new_tetromino(Phoenix.LiveView.Socket.t()) :: Phoenix.LiveView.Socket.t()
  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  @spec show(Phoenix.LiveView.Socket.t()) :: Phoenix.LiveView.Socket.t()
  defp show(socket) do
    assign(socket,
      points: Tetromino.points(socket.assigns.tetro)
    )
  end

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino()
    |> show()
  end

  @spec down(Phoenix.LiveView.Socket.t()) :: Phoenix.LiveView.Socket.t()
  @doc """
  Takes the tetromino and moves it down the Y axis one
  value
  """
  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  @impl true
  @spec handle_info(:tick, Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info(:tick, socket) do
    {:noreply, socket |> down() |> show()}
  end
end
