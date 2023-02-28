defmodule Bizz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BizzWeb.Telemetry,
      # Start the Ecto repository
      Bizz.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bizz.PubSub},
      # Start Finch
      {Finch, name: Bizz.Finch},
      # Start the Endpoint (http/https)
      BizzWeb.Endpoint
      # Start a worker by calling: Bizz.Worker.start_link(arg)
      # {Bizz.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bizz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BizzWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
