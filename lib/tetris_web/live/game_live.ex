defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  alias Tetris.Tetromino

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {
      :ok,
      socket
      |> new_tetromino()
    }
  end

  @impl true
  def render(assigns) do
    ~L"""
    <% {x, y} = @tetro.location %>
    <section class="phx-hero">
      <pre>
        Shape: <%= @tetro.shape %>
        Rotation: <%= @tetro.rotation %>
        Location: {<%= x %>, <%= y %>}
      </pre>
    </section>
    """
  end

  @doc """
  Assigns a new random tetromino block via the constructor
  to the socket (state)
  """
  def new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  @doc """
  Takes the tetromino and moves it down the Y axis one
  value
  """
  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end
end
