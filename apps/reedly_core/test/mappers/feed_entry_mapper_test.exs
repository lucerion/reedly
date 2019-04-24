defmodule Reedly.Core.Test.FeedEntryMapperTest do
  use ExUnit.Case

  alias Reedly.Core.Mappers.FeedEntryMapper
  alias Reedly.Core.Test.FeederExHelpers

  describe "map()" do
    test "returns a feed entry attributes" do
      feeder_ex_entry = FeederExHelpers.build_entry()
      feed_entry_attributes = FeederExHelpers.to_feed_entry_attributes(feeder_ex_entry)

      assert FeedEntryMapper.map(feeder_ex_entry) == feed_entry_attributes
    end

    test "returns a list of feed entries attributes" do
      feeder_ex_entry_1 = FeederExHelpers.build_entry()
      feeder_ex_entry_2 = FeederExHelpers.build_entry()
      feeder_ex_entry_3 = FeederExHelpers.build_entry()
      feeder_ex_entries = [feeder_ex_entry_1, feeder_ex_entry_2, feeder_ex_entry_3]

      feed_entry_attributes_1 = FeederExHelpers.to_feed_entry_attributes(feeder_ex_entry_1)
      feed_entry_attributes_2 = FeederExHelpers.to_feed_entry_attributes(feeder_ex_entry_2)
      feed_entry_attributes_3 = FeederExHelpers.to_feed_entry_attributes(feeder_ex_entry_3)
      feed_entries_attributes = [feed_entry_attributes_1, feed_entry_attributes_2, feed_entry_attributes_3]

      assert FeedEntryMapper.map(feeder_ex_entries) == feed_entries_attributes
    end
  end
end
