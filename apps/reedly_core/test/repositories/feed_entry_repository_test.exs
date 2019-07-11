defmodule Reedly.Core.Test.FeedEntryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedEntryRepository
  alias Reedly.Core.Test.FeedEntryTestHelper

  describe "all()" do
    test "returns all feed entries" do
      attributes_before_create =
        FeedEntryTestHelper.create(count: 3)
        |> FeedEntryTestHelper.attributes()

      attributes_after_create =
        FeedEntryRepository.all()
        |> FeedEntryTestHelper.attributes()

      assert attributes_before_create == attributes_after_create
    end
  end
end
