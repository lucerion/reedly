defmodule Reedly.API.Test.ResolverCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case
      use Reedly.Core.Test.RepoCase

      import Reedly.API.Test.ResolverCase
    end
  end

  setup do
    {:ok, [parent: %{}, args: %{}, resolution: %Absinthe.Resolution{}]}
  end
end
