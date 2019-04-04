defmodule Reedly.Parser.Test.FeedEntryMapperTest do
  use ExUnit.Case

  alias Reedly.Parser.Mappers.FeedEntryMapper
  alias Reedly.Parser.Test.{Helpers, FeederExEntryFactory}

  describe "map()" do
    test "returns a feed entry attributes" do
      feed_entry = FeederExEntryFactory.build()
      feed_entry_attributes = Helpers.feed_entry_attributes(feed_entry)

      assert FeedEntryMapper.map(feed_entry) == feed_entry_attributes
    end

    test "returns a list of feed entries attributes" do
      feed_entry_1 = FeederExEntryFactory.build()
      feed_entry_2 = FeederExEntryFactory.build()
      feed_entry_3 = FeederExEntryFactory.build()
      feed_entries = [feed_entry_1, feed_entry_2, feed_entry_3]

      feed_entry_attributes_1 = Helpers.feed_entry_attributes(feed_entry_1)
      feed_entry_attributes_2 = Helpers.feed_entry_attributes(feed_entry_2)
      feed_entry_attributes_3 = Helpers.feed_entry_attributes(feed_entry_3)
      feed_entries_attributes = [feed_entry_attributes_1, feed_entry_attributes_2, feed_entry_attributes_3]

      assert FeedEntryMapper.map(feed_entries) == feed_entries_attributes
    end
  end
end
