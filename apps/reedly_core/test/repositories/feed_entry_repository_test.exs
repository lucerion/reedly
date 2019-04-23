defmodule Reedly.Core.Test.FeedEntryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedEntryRepository
  alias Reedly.Core.Test.FeedEntryHelpers

  describe "all()" do
    test "returns all feed entries" do
      {:ok, feed_entry_1} = FeedEntryHelpers.create()
      {:ok, feed_entry_2} = FeedEntryHelpers.create()
      {:ok, feed_entry_3} = FeedEntryHelpers.create()

      attributes_before_create = sort_feed_entries_attributes([feed_entry_1, feed_entry_2, feed_entry_3])
      attributes_after_create = sort_feed_entries_attributes(FeedEntryRepository.all())

      assert attributes_before_create == attributes_after_create
    end
  end

  defp sort_feed_entries_attributes(feed_entries) do
    feed_entries
    |> FeedEntryHelpers.attributes()
    |> Enum.sort_by(& &1.entity_id)
  end
end
