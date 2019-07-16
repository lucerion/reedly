defmodule Reedly.Database.Application do
  @moduledoc "Reedly Database application"

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Reedly.Database.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: Reedly.Database.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
