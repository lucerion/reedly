defmodule Reedly.Core.Test.FeedsTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  import Mock

  alias Reedly.Core.Feeds
  alias Reedly.Core.Test.Mocks
  alias Reedly.Database.Test.{FeedTestFactory, FeedTestHelper, FeedEntryTestFactory, CategoryTestFactory}

  describe "all/0" do
    test "returns all feeds" do
      category = CategoryTestFactory.create()

      existing_feeds = [
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 1),
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 2),
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 3)
      ]

      feeds = Feeds.all()

      assert FeedTestHelper.equal?(feeds, existing_feeds)
    end
  end

  describe "update/1" do
    test "updates a feed" do
      feed = FeedTestFactory.create(entries_count: 3)
      new_attributes = FeedTestFactory.build_attributes(entries_count: 2)

      {:ok, updated_feed} =
        with_mocks(Mocks.feed_fetch_and_parse_mock(new_attributes)) do
          Feeds.update(feed)
        end

      assert length(updated_feed.entries) == 5
      refute updated_feed.title == feed.title
      refute updated_feed.updated == feed.updated
    end

    test "updates feed title and updated attributes when there are no new entries" do
      entries = FeedEntryTestFactory.build_attributes(count: 3)
      new_attributes = FeedTestFactory.build_attributes(entries: entries)
      feed = FeedTestFactory.create(entries: entries)

      {:ok, updated_feed} =
        with_mocks(Mocks.feed_fetch_and_parse_mock(new_attributes)) do
          Feeds.update(feed)
        end

      assert updated_feed.entries == feed.entries
      assert updated_feed.title == new_attributes.title
      assert updated_feed.updated == NaiveDateTime.truncate(new_attributes.updated, :second)
    end
  end
end
