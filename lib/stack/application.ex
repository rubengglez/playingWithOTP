defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, state) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: StackSup.Worker.start_link(arg)
      # {StackSup.Worker, arg},
      # Stack.start_link([])
      %{
        id: Stack.Supervisor,
        start: {Stack.Supervisor, :start_link, state}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
