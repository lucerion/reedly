defmodule Reedly.Core.Test.FeedEntryMapperTest do
  use ExUnit.Case

  alias Reedly.Core.Mappers.FeedEntryMapper
  alias Reedly.Core.Test.FeederExTestHelper

  describe "map()" do
    test "returns a feed entry attributes" do
      feeder_ex_entry = FeederExTestHelper.build_entry()
      feed_entry_attributes = FeederExTestHelper.to_feed_entry_attributes(feeder_ex_entry)

      assert FeedEntryMapper.map(feeder_ex_entry) == feed_entry_attributes
    end

    test "returns a list of feed entries attributes" do
      feeder_ex_entries = FeederExTestHelper.build_entry(count: 3)
      feed_entries_attributes = FeederExTestHelper.to_feed_entry_attributes(feeder_ex_entries)

      assert FeedEntryMapper.map(feeder_ex_entries) == feed_entries_attributes
    end
  end
end
