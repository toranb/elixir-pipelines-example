defmodule Pipelinez.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PipelinezWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pipelinez.PubSub},
      # Start the Endpoint (http/https)
      PipelinezWeb.Endpoint
      # Start a worker by calling: Pipelinez.Worker.start_link(arg)
      # {Pipelinez.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pipelinez.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PipelinezWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
