defmodule Reedly.Database.Test.RepoCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox
  alias Reedly.Database.Repo

  using do
    quote do
      alias Reedly.Database.Repo

      import Reedly.Database.Test.RepoCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Repo, {:shared, self()})
    end

    :ok
  end
end
