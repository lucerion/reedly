defmodule Reedly.Core.Test.FeedRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.{Repositories.FeedRepository, Repo}
  alias Reedly.Core.Test.{Helpers, FeedHelpers, CategoryHelpers}

  describe "all()" do
    test "returns feeds with their entries" do
      FeedHelpers.create(entries_count: 1)
      FeedHelpers.create(entries_count: 2)
      FeedHelpers.create(entries_count: 3)

      feeds = FeedRepository.all()
      entries = Enum.flat_map(feeds, & &1.entries)

      assert length(feeds) == 3
      assert length(entries) == 6
    end
  end

  describe "create()" do
    test "creates a feed" do
      feed_attributes = FeedHelpers.build_attributes(entries_count: 2)

      {:ok, feed} = FeedRepository.create(feed_attributes)

      assert FeedHelpers.attributes(feed) == feed_attributes
    end

    test "returns feed_url required validation error without feed_url attribute" do
      assert Helpers.validation_error?(FeedRepository.create(), :feed_url, :required) == true
    end

    test "returns feed_url uniqness validation error if feed_url is not unique" do
      feed_attributes = %{feed_url: Faker.Internet.url()}
      FeedRepository.create(feed_attributes)

      result = FeedRepository.create(feed_attributes)

      assert Helpers.validation_error?(result, :feed_url, :unique) == true
    end

    test "creates feed with category" do
      {:ok, category} = CategoryHelpers.create()

      {:ok, feed} = FeedRepository.create(%{category_id: category.id, feed_url: Faker.Internet.url()})

      assert Repo.preload(feed, [:category]).category == category
    end
  end

  describe "update()" do
    test "updates a feed" do
      {:ok, feed} = FeedHelpers.create(entries_count: 2)

      new_feed_attributes = FeedHelpers.build_attributes(entries_count: 2)
      {:ok, updated_feed} = FeedRepository.update(feed, new_feed_attributes)

      refute feed.title == updated_feed.title
      refute feed.updated == updated_feed.updated
      assert length(updated_feed.entries) == 4
    end
  end
end
