defmodule Reedly.API.Test.FeedEntryResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.FeedEntryResolver
  alias Reedly.Database.Test.{FeedEntryTestHelper, FeedEntryTestFactory}

  describe "all/3" do
    test "returns all feed entries", %{parent: parent, args: args, resolution: resolution} do
      existing_entries = FeedEntryTestFactory.create(count: 3)

      {:ok, entries} = FeedEntryResolver.all(parent, args, resolution)

      assert FeedEntryTestHelper.equal?(entries, existing_entries)
    end
  end

  describe "update/3" do
    test "updates a category", %{parent: parent, resolution: resolution} do
      feed_entry = FeedEntryTestFactory.create(%{read: false})

      {:ok, updated_feed_entry} = FeedEntryResolver.update(parent, %{id: feed_entry.id, read: true}, resolution)

      refute feed_entry.read == updated_feed_entry.read
    end

    test "fails if category not found", %{parent: parent, resolution: resolution} do
      assert FeedEntryResolver.update(parent, %{id: 42, read: true}, resolution) == {:error, nil}
    end
  end
end
