defmodule Stack.Server do
  use GenServer

  def start_link(pidStash) do
    GenServer.start_link(__MODULE__, pidStash, name: __MODULE__, debug: [:trace])
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

  ########## handlers ###############

  def init(pidStash) do
    initState = GenServer.call(pidStash, :get_value)
    {:ok, {initState, pidStash}}
  end

  def handle_call(:pop, _from, {[], pidStash}) do
    {:reply, [], {[1, 2, 3], pidStash}}
  end

  def handle_call(:pop, _from, {[head | tail], pidStash}) do
    {:reply, head, {tail, pidStash}}
  end

  def handle_call(:getList, _from, {state, pidStash}) do
    {:reply, state, {state, pidStash}}
  end

  def handle_cast({:push, value}, {state, pidStash}) when value < 100 do
    {:noreply, {[value | state], pidStash}}
  end

  def handle_cast({:push, value}, {state, pidStash}) when value >= 100 do
    # System.halt(value)
    [head | tail] = []
  end

  def terminate(_reason, {state, pidStash}) do
    GenServer.cast(pidStash, {:set_value, state})
    IO.puts("terminating")
  end
end
