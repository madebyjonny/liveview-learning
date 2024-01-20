defmodule LiveviewLearning.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveviewLearningWeb.Telemetry,
      LiveviewLearning.Repo,
      {DNSCluster, query: Application.get_env(:liveview_learning, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveviewLearning.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveviewLearning.Finch},
      # Start a worker by calling: LiveviewLearning.Worker.start_link(arg)
      # {LiveviewLearning.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveviewLearningWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveviewLearning.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveviewLearningWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
