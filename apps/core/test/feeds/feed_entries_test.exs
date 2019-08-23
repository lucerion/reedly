defmodule Reedly.Core.Test.FeedEntriesTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  alias Reedly.Core.Feeds.FeedEntries
  alias Reedly.Database.Test.{FeedEntryTestHelper, FeedEntryTestFactory}

  describe "all/1" do
    test "returns all feed entries" do
      existing_entries = FeedEntryTestFactory.create(count: 3)

      entries = FeedEntries.all()

      assert FeedEntryTestHelper.equal?(entries, existing_entries)
    end
  end

  describe "update/1" do
    test "updates a feed entry" do
      feed_entry = FeedEntryTestFactory.create(%{read: false})

      {:ok, updated_feed_entry} = FeedEntries.update(%{id: feed_entry.id, read: true})

      refute feed_entry.read == updated_feed_entry.read
    end

    test "fails when a feed entry not found" do
      result = FeedEntries.update(%{id: 42, read: true})

      assert result == {:error, nil}
    end
  end
end
