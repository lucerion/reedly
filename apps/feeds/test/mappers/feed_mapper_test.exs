defmodule Reedly.Feeds.Test.FeedMapperTest do
  use ExUnit.Case

  alias Reedly.Feeds.Mappers.FeedMapper
  alias Reedly.Feeds.Test.FeederExTestHelper

  describe "map/1" do
    test "returns a feed attributes" do
      feeder_ex_feed = FeederExTestHelper.build_feed(entries_count: 3)
      feed_attributes = FeederExTestHelper.to_feed_attributes(feeder_ex_feed)

      assert FeedMapper.map(feeder_ex_feed) == feed_attributes
    end
  end
end
