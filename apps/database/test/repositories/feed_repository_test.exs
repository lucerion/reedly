defmodule Reedly.Database.Test.FeedRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.FeedRepository
  alias Reedly.Database.Test.{FeedTestHelper, FeedTestFactory, CategoryTestFactory}

  describe "all/0" do
    test "returns feeds with their entries" do
      existing_feeds = [
        FeedTestFactory.create(entries_count: 1),
        FeedTestFactory.create(entries_count: 2),
        FeedTestFactory.create(entries_count: 3)
      ]

      feeds = FeedRepository.all()

      assert FeedTestHelper.equal?(feeds, existing_feeds)
    end
  end

  describe "create/1" do
    test "creates a feed" do
      feed_attributes = FeedTestFactory.build_attributes(entries_count: 2)

      {:ok, feed} = FeedRepository.create(feed_attributes)

      assert FeedTestHelper.equal?(feed, feed_attributes)
    end

    test "returns feed_url required validation error without feed_url attribute" do
      assert validation_error?(FeedRepository.create(), :feed_url, :required)
    end

    test "returns feed_url uniqness validation error if feed_url is not unique" do
      feed_attributes = %{feed_url: Faker.Internet.url()}
      FeedRepository.create(feed_attributes)

      result = FeedRepository.create(feed_attributes)

      assert validation_error?(result, :feed_url, :unique)
    end

    test "creates feed with category" do
      category = CategoryTestFactory.create()

      {:ok, feed} = FeedRepository.create(%{category_id: category.id, feed_url: Faker.Internet.url()})

      assert feed.category == category
    end

    test "fails when category_id is not correct" do
      attributes = FeedTestFactory.build_attributes(%{category_id: 42})

      result = FeedRepository.create(attributes)

      assert validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      category = CategoryTestFactory.create(%{type: "link"})
      attributes = FeedTestFactory.build_attributes(%{category_id: category.id})

      result = FeedRepository.create(attributes)

      assert validation_error?(result, :category_id, :category_type)
    end
  end

  describe "update/2" do
    test "updates a feed" do
      feed = FeedTestFactory.create(entries_count: 2)

      new_feed_attributes = FeedTestFactory.build_attributes(entries_count: 2)
      {:ok, updated_feed} = FeedRepository.update(feed, new_feed_attributes)

      refute feed.title == updated_feed.title
      refute feed.updated == updated_feed.updated
      assert length(updated_feed.entries) == 4
    end

    test "updates feed category" do
      category = CategoryTestFactory.create()
      feed = FeedTestFactory.create()

      {:ok, updated_feed} = FeedRepository.update(feed, %{category_id: category.id})

      refute feed.category_id == updated_feed.category_id
    end

    test "fails when category_id is not correct" do
      feed = FeedTestFactory.create()

      result = FeedRepository.update(feed, %{category_id: 42})

      assert validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      category = CategoryTestFactory.create(%{type: "link"})
      feed = FeedTestFactory.create()

      result = FeedRepository.update(feed, %{category_id: category.id})

      assert validation_error?(result, :category_id, :category_type)
    end
  end
end
