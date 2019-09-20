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

  describe "filter/1" do
    test "returns feed entries by category with category_id argument" do
      %{category: category_1, entries: feed_entries_1} = FeedEntryTestFactory.create_for_category(count: 2)
      %{category: category_2, entries: feed_entries_2} = FeedEntryTestFactory.create_for_category(count: 3)

      filtered_feed_entries_1 = FeedEntries.filter(%{category_id: category_1.id})
      filtered_feed_entries_2 = FeedEntries.filter(%{category_id: category_2.id})

      assert FeedEntryTestHelper.equal?(filtered_feed_entries_1, feed_entries_1)
      assert FeedEntryTestHelper.equal?(filtered_feed_entries_2, feed_entries_2)
    end

    test "returns feed entries by feed with feed_id argument" do
      %{feed: feed_1, entries: feed_entries_1} = FeedEntryTestFactory.create_for_category(count: 2)
      %{feed: feed_2, entries: feed_entries_2} = FeedEntryTestFactory.create_for_category(count: 3)

      filtered_feed_entries_1 = FeedEntries.filter(%{feed_id: feed_1.id})
      filtered_feed_entries_2 = FeedEntries.filter(%{feed_id: feed_2.id})

      assert FeedEntryTestHelper.equal?(filtered_feed_entries_1, feed_entries_1)
      assert FeedEntryTestHelper.equal?(filtered_feed_entries_2, feed_entries_2)
    end

    test "returns read/unread feed entries with read argument" do
      %{read_entries: read_feed_entries, unread_entries: unread_feed_entries} =
        FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 3)

      filtered_read_feed_entries = FeedEntries.filter(%{read: true})
      filtered_unread_feed_entries = FeedEntries.filter(%{read: false})

      assert FeedEntryTestHelper.equal?(filtered_read_feed_entries, read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_unread_feed_entries, unread_feed_entries)
    end

    test "returns read/unread feed entries by category with category_id and read arguments" do
      %{
        category: category_1,
        read_entries: category_1_read_feed_entries,
        unread_entries: category_1_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 1, unread_count: 3)

      %{
        category: category_2,
        read_entries: category_2_read_feed_entries,
        unread_entries: category_2_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 4)

      filtered_category_1_read_feed_entries = FeedEntries.filter(%{category_id: category_1.id, read: true})
      filtered_category_1_unread_feed_entries = FeedEntries.filter(%{category_id: category_1.id, read: false})
      filtered_category_2_read_feed_entries = FeedEntries.filter(%{category_id: category_2.id, read: true})
      filtered_category_2_unread_feed_entries = FeedEntries.filter(%{category_id: category_2.id, read: false})

      assert FeedEntryTestHelper.equal?(filtered_category_1_read_feed_entries, category_1_read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_1_unread_feed_entries, category_1_unread_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_2_read_feed_entries, category_2_read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_2_unread_feed_entries, category_2_unread_feed_entries)
    end

    test "returns read/unread feed entries by feed with feed_id and arguments" do
      %{
        feed: feed_1,
        read_entries: feed_1_read_entries,
        unread_entries: feed_1_unread_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 3, unread_count: 4)

      %{
        feed: feed_2,
        read_entries: feed_2_read_entries,
        unread_entries: feed_2_unread_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 1)

      filtered_feed_1_read_entries = FeedEntries.filter(%{feed_id: feed_1.id, read: true})
      filtered_feed_1_unread_entries = FeedEntries.filter(%{feed_id: feed_1.id, read: false})
      filtered_feed_2_read_entries = FeedEntries.filter(%{feed_id: feed_2.id, read: true})
      filtered_feed_2_unread_entries = FeedEntries.filter(%{feed_id: feed_2.id, read: false})

      assert FeedEntryTestHelper.equal?(filtered_feed_1_read_entries, feed_1_read_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_1_unread_entries, feed_1_unread_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_2_read_entries, feed_2_read_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_2_unread_entries, feed_2_unread_entries)
    end

    test "returns empty list without arguments" do
      assert FeedEntries.filter() == []
    end

    test "returns empty list with wrong arguments" do
      assert FeedEntries.filter(%{arg: "value"}) == []
      assert FeedEntries.filter(%{}) == []
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
