defmodule Reedly.API.Test.FeedEntryResolverTest do
  use ExUnit.Case
  import Mock

  alias Reedly.API.Resolvers.FeedEntryResolver

  describe "all()" do
    test "returns all feed entries" do
      entries = ~w[entry_1 entry_2 entry_3]a

      {:ok, entries_from_db} =
        with_mocks([entries_mock(entries)]) do
          FeedEntryResolver.all(nil, nil, nil)
        end

      assert entries == entries_from_db
    end
  end

  defp entries_mock(entries) do
    {Reedly.Core.Repositories.FeedEntryRepository, [], [all: fn -> entries end]}
  end
end
