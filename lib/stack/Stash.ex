defmodule Stack.Stash do

  use GenServer

  def start_link(initState) do
    GenServer.start_link(__MODULE__, initState, name: __MODULE__, debug: [:trace])
  end

  def get_value do
    GenServer.call(__MODULE__, :get_value)
  end

  def set_value(newState) do
    GenServer.cast(__MODULE__, {:set_value, newState})
  end

  def handle_call(:get_value, _from, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:set_value, newState}, state) do
    {:noreply, newState}
  end

end
