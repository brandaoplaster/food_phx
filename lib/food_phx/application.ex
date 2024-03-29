defmodule FoodPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias FoodPhx.Carts.Boundary.CartSession

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FoodPhx.Repo,
      # Start the Telemetry supervisor
      FoodPhxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FoodPhx.PubSub},
      # Start the Endpoint (http/https)
      FoodPhxWeb.Endpoint,
      CartSession
      # Start a worker by calling: FoodPhx.Worker.start_link(arg)
      # {FoodPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
