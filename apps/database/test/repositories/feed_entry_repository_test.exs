defmodule Reedly.Database.Test.FeedEntryRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.FeedEntryRepository

  alias Reedly.Database.Test.{
    FeedEntryTestHelper,
    FeedTestHelper,
    FeedEntryTestFactory,
    FeedTestFactory
  }

  describe "all/0" do
    test "returns all feed entries" do
      feed = FeedTestFactory.create(entries_count: 3)

      entries = FeedEntryRepository.all()

      assert FeedEntryTestHelper.equal?(entries, feed.entries)
      assert feed_preloaded?(entries, feed)
    end
  end

  describe "filter/1" do
    test "returns feed entries by category with category_id argument" do
      %{category: category_1, feed: feed_1, entries: feed_entries_1} =
        FeedEntryTestFactory.create_for_category(count: 2)

      %{category: category_2, feed: feed_2, entries: feed_entries_2} =
        FeedEntryTestFactory.create_for_category(count: 3)

      filtered_feed_entries_1 = FeedEntryRepository.filter(%{category_id: category_1.id})
      filtered_feed_entries_2 = FeedEntryRepository.filter(%{category_id: category_2.id})

      assert FeedEntryTestHelper.equal?(filtered_feed_entries_1, feed_entries_1)
      assert FeedEntryTestHelper.equal?(filtered_feed_entries_2, feed_entries_2)

      assert feed_preloaded?(filtered_feed_entries_1, feed_1)
      assert feed_preloaded?(filtered_feed_entries_2, feed_2)
    end

    test "returns feed entries without category when category_id is nil" do
      %{category: category, feed: feed, entries: feed_entries} = FeedEntryTestFactory.create_for_category(count: 3)

      feed_entries_without_category = FeedEntryTestFactory.create(count: 3)

      filtered_feed_entries = FeedEntryRepository.filter(%{category_id: nil})

      assert FeedEntryTestHelper.equal?(filtered_feed_entries, feed_entries_without_category)
    end

    test "returns feed entries by feed with feed_id argument" do
      %{feed: feed_1, entries: feed_entries_1} = FeedEntryTestFactory.create_for_category(count: 2)
      %{feed: feed_2, entries: feed_entries_2} = FeedEntryTestFactory.create_for_category(count: 3)

      filtered_feed_entries_1 = FeedEntryRepository.filter(%{feed_id: feed_1.id})
      filtered_feed_entries_2 = FeedEntryRepository.filter(%{feed_id: feed_2.id})

      assert FeedEntryTestHelper.equal?(filtered_feed_entries_1, feed_entries_1)
      assert FeedEntryTestHelper.equal?(filtered_feed_entries_2, feed_entries_2)
    end

    test "returns read/unread feed entries with read argument" do
      %{feed: feed, read_entries: read_feed_entries, unread_entries: unread_feed_entries} =
        FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 3)

      filtered_read_feed_entries = FeedEntryRepository.filter(%{read: true})
      filtered_unread_feed_entries = FeedEntryRepository.filter(%{read: false})

      assert FeedEntryTestHelper.equal?(filtered_read_feed_entries, read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_unread_feed_entries, unread_feed_entries)

      assert feed_preloaded?(filtered_read_feed_entries, feed)
      assert feed_preloaded?(filtered_unread_feed_entries, feed)
    end

    test "returns read/unread feed entries by category with category_id and read arguments" do
      %{
        category: category_1,
        feed: category_1_feed,
        read_entries: category_1_read_feed_entries,
        unread_entries: category_1_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 1, unread_count: 3)

      %{
        category: category_2,
        feed: category_2_feed,
        read_entries: category_2_read_feed_entries,
        unread_entries: category_2_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 4)

      filtered_category_1_read_feed_entries = FeedEntryRepository.filter(%{category_id: category_1.id, read: true})
      filtered_category_1_unread_feed_entries = FeedEntryRepository.filter(%{category_id: category_1.id, read: false})
      filtered_category_2_read_feed_entries = FeedEntryRepository.filter(%{category_id: category_2.id, read: true})
      filtered_category_2_unread_feed_entries = FeedEntryRepository.filter(%{category_id: category_2.id, read: false})

      assert FeedEntryTestHelper.equal?(filtered_category_1_read_feed_entries, category_1_read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_1_unread_feed_entries, category_1_unread_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_2_read_feed_entries, category_2_read_feed_entries)
      assert FeedEntryTestHelper.equal?(filtered_category_2_unread_feed_entries, category_2_unread_feed_entries)

      assert feed_preloaded?(filtered_category_1_read_feed_entries, category_1_feed)
      assert feed_preloaded?(filtered_category_1_unread_feed_entries, category_1_feed)
      assert feed_preloaded?(filtered_category_2_read_feed_entries, category_2_feed)
      assert feed_preloaded?(filtered_category_2_unread_feed_entries, category_2_feed)
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

      filtered_feed_1_read_entries = FeedEntryRepository.filter(%{feed_id: feed_1.id, read: true})
      filtered_feed_1_unread_entries = FeedEntryRepository.filter(%{feed_id: feed_1.id, read: false})
      filtered_feed_2_read_entries = FeedEntryRepository.filter(%{feed_id: feed_2.id, read: true})
      filtered_feed_2_unread_entries = FeedEntryRepository.filter(%{feed_id: feed_2.id, read: false})

      assert FeedEntryTestHelper.equal?(filtered_feed_1_read_entries, feed_1_read_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_1_unread_entries, feed_1_unread_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_2_read_entries, feed_2_read_entries)
      assert FeedEntryTestHelper.equal?(filtered_feed_2_unread_entries, feed_2_unread_entries)
    end

    test "returns empty list with invalid arguments" do
      assert FeedEntryRepository.filter(%{arg: "value"}) == []
      assert FeedEntryRepository.filter(%{}) == []
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

  defp feed_preloaded?(feed_entries, feed),
    do: Enum.all?(feed_entries, &FeedTestHelper.equal?(&1.feed, feed))
end
