defmodule Stack.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    result = {:ok, pid} = Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
    start_workers(pid, init_arg)
    result
  end

  def start_workers(pid, init_arg) do
    {:ok, pidStash} =
      Supervisor.start_child(pid, %{
        id: Stack.Stash,
        start: {Stack.Stash, :start_link, [init_arg]}
      })

    {:ok, pidServer} =
      Supervisor.start_child(pid, %{
        id: Stack.Server,
        start: {Stack.Server, :start_link, [pidStash]}
      })
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
