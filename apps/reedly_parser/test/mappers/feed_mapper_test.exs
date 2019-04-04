defmodule Reedly.Parser.Test.FeedMapperTest do
  use ExUnit.Case

  alias Reedly.Parser.Mappers.FeedMapper
  alias Reedly.Parser.Test.{Helpers, FeederExEntryFactory, FeederExFeedFactory}

  describe "map()" do
    test "returns a feed attributes" do
      feed_entry_1 = FeederExEntryFactory.build()
      feed_entry_2 = FeederExEntryFactory.build()
      feed_entry_3 = FeederExEntryFactory.build()
      feed_entries = [feed_entry_1, feed_entry_2, feed_entry_3]
      feed = FeederExFeedFactory.build(feed_entries)
      feed_attributes = Helpers.feed_attributes(feed)

      assert FeedMapper.map(feed) == feed_attributes
    end
  end
end
