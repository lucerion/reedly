defmodule Reedly.Core.Application do
  @moduledoc "Reedly Core application"

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Reedly.Core.Scheduler, [])
    ]

    opts = [strategy: :one_for_one, name: Reedly.Core.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
