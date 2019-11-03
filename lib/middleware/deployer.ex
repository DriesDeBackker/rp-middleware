defmodule ReactiveMiddleware.Deployer do
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
  Deploys the given program to the remote node.
  """
	def deploy(remote, program) do
		GenServer.cast(__MODULE__,{:deploy, program, remote})
		:ok
	end
  
	####################
	# SERVER CALLBACKS #
	####################

	def init([]) do
		Logger.info("Starting the Deployer")
		{:ok, %{}}
	end

 	def handle_cast({:deploy, program, remote}, state) do
    evaluator = :global.whereis_name({remote, :evaluator})
		GenServer.cast(evaluator, {:evaluate, program})
    {:noreply, state}
  end
end