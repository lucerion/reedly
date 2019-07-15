defmodule Reedly.Core.Test.FeedEntriesTest do
  use ExUnit.Case
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.FeedEntries
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all/1" do
    test "returns all feed entries" do
      entries = FeedEntryTestHelper.create(count: 3)

      all_entries = FeedEntries.all()

      assert FeedEntryTestHelper.equal?(entries, all_entries)
    end
  end

  describe "update/1" do
    test "updates a feed entry" do
      {:ok, feed_entry} = FeedEntryTestHelper.create(%{read: false})

      {:ok, updated_feed_entry} = FeedEntries.update(%{id: feed_entry.id, read: true})

      refute feed_entry.read == updated_feed_entry.read
    end

    test "fails when a feed entry not found" do
      result = FeedEntries.update(%{id: 42, read: true})

      assert result == {:error, nil}
    end
  end
end
