defmodule Stack do
  use GenServer

  def start_link(initState) do
    GenServer.start_link(__MODULE__, initState, name: __MODULE__, debug: [:trace])
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  def list do
    GenServer.call(__MODULE__, :getList)
  end

  def handle_call(:pop, _from, []) do
    {:reply, [], [1, 2, 3]}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:getList, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, value}, state) when value < 100 do
    {:noreply, [value | state]}
  end

  def handle_cast({:push, value}, state) when value >= 100 do
    # System.halt(value)
    [head | tail] = []
  end

  def terminate(_, _) do
    IO.puts("terminating")
  end
end
