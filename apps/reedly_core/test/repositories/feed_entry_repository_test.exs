defmodule Reedly.Core.Test.FeedEntryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedEntryRepository
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all()" do
    test "returns all feed entries" do
      entries = FeedEntryTestHelper.create(count: 3)

      all_entries = FeedEntryRepository.all()

      assert FeedEntryTestHelper.equal?(entries, all_entries)
    end
  end

  describe "update/2" do
    test "updates a feed entry" do
      {:ok, feed_entry} = FeedEntryTestHelper.create(%{read: false})

      {:ok, updated_feed_entry} = FeedEntryRepository.update(feed_entry, %{read: true})

      refute feed_entry.read == updated_feed_entry.read
    end

    test "not updates a feed entry if updated attribute is not 'read'" do
      {:ok, feed_entry} = FeedEntryTestHelper.create()

      {:ok, updated_feed_entry} = FeedEntryRepository.update(feed_entry, %{title: "Title updated!"})

      assert feed_entry == updated_feed_entry
    end
  end
end
