defmodule Reedly.Core.Test.RepoCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Reedly.Core.Repo

  using do
    quote do
      alias Reedly.Core.Repo

      import Reedly.Core.Test.RepoCase
    end
  end

  setup tags do
    Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end
end
