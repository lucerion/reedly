defmodule Reedly.Scheduler.Application do
  @moduledoc "Reedly scheduler application"

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Reedly.Scheduler, [])
    ]

    opts = [strategy: :one_for_one, name: Reedly.Scheduler.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
