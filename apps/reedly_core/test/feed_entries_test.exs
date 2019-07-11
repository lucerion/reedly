defmodule Reedly.Core.Test.FeedEntriesTest do
  use ExUnit.Case
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.FeedEntries
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all/1" do
    test "returns all feed entries" do
      entries = FeedEntryTestHelper.create(count: 3)

      all_entries = FeedEntries.all()

      assert FeedEntryTestHelper.equal?(entries, all_entries)
    end
  end
end
