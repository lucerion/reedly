defmodule Reedly.Core.Test.FeedsTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  import Mock

  alias Reedly.Core.Feeds
  alias Reedly.Core.Test.Mocks
  alias Reedly.Database.Test.{FeedTestFactory, FeedEntryTestFactory}

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
