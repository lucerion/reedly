defmodule Reedly.API.Application do
  @moduledoc "Reedly API application"

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      {Plug.Cowboy, scheme: :http, plug: Reedly.API.Router, options: [port: Application.get_env(:api, :port)]}
    ]

    opts = [strategy: :one_for_one, name: Reedly.API.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
