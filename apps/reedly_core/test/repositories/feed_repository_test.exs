defmodule Reedly.Core.Test.Repositories.FeedRepositoryTest do
  use ExUnit.Case

  alias Reedly.Core.{Repo, Repositories.FeedRepository}
  alias Reedly.Core.Test.{Helpers, FeedAttributesFactory, FeedEntryAttributesFactory}

  describe "create()" do
    test "creates a feed record" do
      feed_entry_attribute_1 = FeedEntryAttributesFactory.build()
      feed_entry_attribute_2 = FeedEntryAttributesFactory.build()
      feed_entries_attributes = [feed_entry_attribute_1, feed_entry_attribute_2]
      feed_attributes = FeedAttributesFactory.build(feed_entries_attributes)

      {:ok, feed} = FeedRepository.create(feed_attributes)

      assert Helpers.feed_attributes_from_feed(feed) == feed_attributes
    end
  end
end
