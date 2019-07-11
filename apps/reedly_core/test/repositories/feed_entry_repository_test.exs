defmodule Reedly.Core.Test.FeedEntryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedEntryRepository
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all()" do
    test "returns all feed entries" do
      entries = FeedEntryTestHelper.create(count: 3)

      all_entries = FeedEntryRepository.all()

      assert FeedEntryTestHelper.equal?(entries, all_entries)
    end
  end
end
