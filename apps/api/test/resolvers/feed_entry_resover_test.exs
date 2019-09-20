defmodule Reedly.API.Test.FeedEntryResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.FeedEntryResolver
  alias Reedly.Database.Test.{FeedEntryTestHelper, FeedEntryTestFactory}

  describe "fetch/3" do
    test "returns all feed entries when arguments are empty", %{parent: parent, resolution: resolution} do
      existing_feed_entries = FeedEntryTestFactory.create(count: 3)

      {:ok, feed_entries} = FeedEntryResolver.fetch(parent, %{}, resolution)

      assert FeedEntryTestHelper.equal?(feed_entries, existing_feed_entries)
    end

    test "returns feed entries by category with category_id argument", %{parent: parent, resolution: resolution} do
      %{category: category_1, entries: existing_feed_entries_1} = FeedEntryTestFactory.create_for_category(count: 2)
      %{category: category_2, entries: existing_feed_entries_2} = FeedEntryTestFactory.create_for_category(count: 3)

      {:ok, feed_entries_1} = FeedEntryResolver.fetch(parent, %{category_id: category_1.id}, resolution)
      {:ok, feed_entries_2} = FeedEntryResolver.fetch(parent, %{category_id: category_2.id}, resolution)

      assert FeedEntryTestHelper.equal?(feed_entries_1, existing_feed_entries_1)
      assert FeedEntryTestHelper.equal?(feed_entries_2, existing_feed_entries_2)
    end

    test "returns feed entries by feed with feed_id argument", %{parent: parent, resolution: resolution} do
      %{feed: feed_1, entries: existing_feed_entries_1} = FeedEntryTestFactory.create_for_category(count: 2)
      %{feed: feed_2, entries: existing_feed_entries_2} = FeedEntryTestFactory.create_for_category(count: 3)

      {:ok, feed_entries_1} = FeedEntryResolver.fetch(parent, %{feed_id: feed_1.id}, resolution)
      {:ok, feed_entries_2} = FeedEntryResolver.fetch(parent, %{feed_id: feed_2.id}, resolution)

      assert FeedEntryTestHelper.equal?(feed_entries_1, existing_feed_entries_1)
      assert FeedEntryTestHelper.equal?(feed_entries_2, existing_feed_entries_2)
    end

    test "returns read/unread feed entries with read argument", %{parent: parent, resolution: resolution} do
      %{read_entries: existing_read_feed_entries, unread_entries: existing_unread_feed_entries} =
        FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 3)

      {:ok, read_feed_entries} = FeedEntryResolver.fetch(parent, %{read: true}, resolution)
      {:ok, unread_feed_entries} = FeedEntryResolver.fetch(parent, %{read: false}, resolution)

      assert FeedEntryTestHelper.equal?(read_feed_entries, existing_read_feed_entries)
      assert FeedEntryTestHelper.equal?(unread_feed_entries, existing_unread_feed_entries)
    end

    test "returns read/unread feed entries by category with category_id and read arguments",
         %{parent: parent, resolution: resolution} do
      %{
        category: category_1,
        read_entries: existing_category_1_read_feed_entries,
        unread_entries: existing_category_1_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 1, unread_count: 3)

      %{
        category: category_2,
        read_entries: existing_category_2_read_feed_entries,
        unread_entries: existing_category_2_unread_feed_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 4)

      {:ok, category_1_read_feed_entries} =
        FeedEntryResolver.fetch(parent, %{category_id: category_1.id, read: true}, resolution)

      {:ok, category_1_unread_feed_entries} =
        FeedEntryResolver.fetch(parent, %{category_id: category_1.id, read: false}, resolution)

      {:ok, category_2_read_feed_entries} =
        FeedEntryResolver.fetch(parent, %{category_id: category_2.id, read: true}, resolution)

      {:ok, category_2_unread_feed_entries} =
        FeedEntryResolver.fetch(parent, %{category_id: category_2.id, read: false}, resolution)

      assert FeedEntryTestHelper.equal?(category_1_read_feed_entries, existing_category_1_read_feed_entries)
      assert FeedEntryTestHelper.equal?(category_1_unread_feed_entries, existing_category_1_unread_feed_entries)
      assert FeedEntryTestHelper.equal?(category_2_read_feed_entries, existing_category_2_read_feed_entries)
      assert FeedEntryTestHelper.equal?(category_2_unread_feed_entries, existing_category_2_unread_feed_entries)
    end

    test "returns read/unread feed entries by feed with feed_id and arguments",
         %{parent: parent, resolution: resolution} do
      %{
        feed: feed_1,
        read_entries: existing_feed_1_read_entries,
        unread_entries: existing_feed_1_unread_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 3, unread_count: 4)

      %{
        feed: feed_2,
        read_entries: existing_feed_2_read_entries,
        unread_entries: existing_feed_2_unread_entries
      } = FeedEntryTestFactory.create_for_category(read_count: 2, unread_count: 1)

      {:ok, feed_1_read_entries} = FeedEntryResolver.fetch(parent, %{feed_id: feed_1.id, read: true}, resolution)
      {:ok, feed_1_unread_entries} = FeedEntryResolver.fetch(parent, %{feed_id: feed_1.id, read: false}, resolution)
      {:ok, feed_2_read_entries} = FeedEntryResolver.fetch(parent, %{feed_id: feed_2.id, read: true}, resolution)
      {:ok, feed_2_unread_entries} = FeedEntryResolver.fetch(parent, %{feed_id: feed_2.id, read: false}, resolution)

      assert FeedEntryTestHelper.equal?(feed_1_read_entries, existing_feed_1_read_entries)
      assert FeedEntryTestHelper.equal?(feed_1_unread_entries, existing_feed_1_unread_entries)
      assert FeedEntryTestHelper.equal?(feed_2_read_entries, existing_feed_2_read_entries)
      assert FeedEntryTestHelper.equal?(feed_2_unread_entries, existing_feed_2_unread_entries)
    end

    test "returns empty list with wrong arguments", %{parent: parent, resolution: resolution} do
      assert FeedEntryResolver.fetch(parent, %{arg: "value"}, resolution) == {:ok, []}
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
