defmodule Reedly.Core.Test.FeedEntryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedEntryRepository
  alias Reedly.Core.Test.FeedEntryHelpers

  describe "all()" do
    test "returns all feed entries" do
      attributes_before_create =
        FeedEntryHelpers.create(count: 3)
        |> FeedEntryHelpers.attributes()

      attributes_after_create =
        FeedEntryRepository.all()
        |> FeedEntryHelpers.attributes()

      assert attributes_before_create == attributes_after_create
    end
  end
end
