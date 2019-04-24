defmodule Reedly.Core.Test.FeedMapperTest do
  use ExUnit.Case

  alias Reedly.Core.Mappers.FeedMapper
  alias Reedly.Core.Test.FeederExHelpers

  describe "map()" do
    test "returns a feed attributes" do
      feeder_ex_entries = [FeederExHelpers.build_entry(), FeederExHelpers.build_entry(), FeederExHelpers.build_entry()]
      feeder_ex_feed = FeederExHelpers.build_feed(feeder_ex_entries)
      feed_attributes = FeederExHelpers.to_feed_attributes(feeder_ex_feed)

      assert FeedMapper.map(feeder_ex_feed) == feed_attributes
    end
  end
end
