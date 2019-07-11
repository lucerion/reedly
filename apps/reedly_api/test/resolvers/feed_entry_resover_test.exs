defmodule Reedly.API.Test.FeedEntryResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.FeedEntryResolver
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all/3" do
    test "returns all feed entries", %{parent: parent, args: args, resolution: resolution} do
      entries = FeedEntryTestHelper.create(count: 3)

      {:ok, all_entries} = FeedEntryResolver.all(parent, args, resolution)

      assert FeedEntryTestHelper.equal?(entries, all_entries)
    end
  end
end
