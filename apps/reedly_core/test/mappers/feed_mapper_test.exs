defmodule Reedly.Core.Test.FeedMapperTest do
  use ExUnit.Case

  alias Reedly.Core.Mappers.FeedMapper
  alias Reedly.Core.Test.FeederExHelpers

  describe "map()" do
    test "returns a feed attributes" do
      feeder_ex_feed = FeederExHelpers.build_feed(entries_count: 3)
      feed_attributes = FeederExHelpers.to_feed_attributes(feeder_ex_feed)

      assert FeedMapper.map(feeder_ex_feed) == feed_attributes
    end
  end
end
