defmodule TodolistApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodolistApiWeb.Telemetry,
      TodolistApi.Repo,
      {DNSCluster, query: Application.get_env(:todolist_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TodolistApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TodolistApi.Finch},
      # Start a worker by calling: TodolistApi.Worker.start_link(arg)
      # {TodolistApi.Worker, arg},
      # Start to serve requests, typically the last entry
      TodolistApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodolistApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodolistApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
