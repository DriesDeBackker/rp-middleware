defmodule ReactiveMiddleware.Evaluator do
  use GenServer
  require Logger
  alias GenServer

  ####################
  # CLIENT INTERFACE #
  ####################

  @doc """
  Start the GenServer.
  """
  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @doc """
  Evaluates a (remotely) sent program locally.
  """
  def evaluate(program) do
    GenServer.cast(__MODULE__, {:evaluate, program})
  end

  ####################
  # SERVER CALLBACKS #
  ####################

  def init([]) do
    Logger.info("Starting the Evaluator")
    {:ok, %{}}
  end

  def handle_cast({:evaluate, program}, state) do
    program.()
    {:noreply, state}
  end
end