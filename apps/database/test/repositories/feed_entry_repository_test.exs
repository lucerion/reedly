defmodule Reedly.Database.Test.FeedEntryRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.FeedEntryRepository
  alias Reedly.Database.Test.{FeedEntryTestHelper, FeedEntryTestFactory}

  describe "all()" do
    test "returns all feed entries" do
      existing_entries = FeedEntryTestFactory.create(count: 3)

      entries = FeedEntryRepository.all()

      assert FeedEntryTestHelper.equal?(entries, existing_entries)
    end
  end

  describe "update/2" do
    test "updates a feed entry" do
      feed_entry = FeedEntryTestFactory.create(%{read: false})

      {:ok, updated_feed_entry} = FeedEntryRepository.update(feed_entry, %{read: true})

      refute feed_entry.read == updated_feed_entry.read
    end

    test "not updates a feed entry if updated attribute is not 'read'" do
      feed_entry = FeedEntryTestFactory.create()

      {:ok, updated_feed_entry} = FeedEntryRepository.update(feed_entry, %{title: "Title updated!"})

      assert feed_entry == updated_feed_entry
    end
  end
end
