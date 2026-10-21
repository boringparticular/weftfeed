defmodule Weftfeed.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WeftfeedWeb.Telemetry,
      Weftfeed.Repo,
      {DNSCluster, query: Application.get_env(:weftfeed, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Weftfeed.PubSub},
      # Start a worker by calling: Weftfeed.Worker.start_link(arg)
      # {Weftfeed.Worker, arg},
      # Start to serve requests, typically the last entry
      WeftfeedWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Weftfeed.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WeftfeedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
