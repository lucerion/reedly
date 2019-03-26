defmodule Reedly.Core.Test.FeedMapperTest do
  use ExUnit.Case

  alias Reedly.Core.Mappers.FeedMapper
  alias Reedly.Core.Test.{Helpers, FeederExEntryFactory, FeederExFeedFactory}

  describe "map()" do
    test "returns a feed attributes" do
      feed_entry_1 = FeederExEntryFactory.build()
      feed_entry_2 = FeederExEntryFactory.build()
      feed_entry_3 = FeederExEntryFactory.build()
      feed_entries = [feed_entry_1, feed_entry_2, feed_entry_3]
      feed = FeederExFeedFactory.build(feed_entries)
      feed_attributes = Helpers.feeder_ex_feed_to_feed_attributes(feed)

      assert FeedMapper.map(feed) == feed_attributes
    end
  end
end
