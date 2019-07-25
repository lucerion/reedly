defmodule Reedly.Database.Test.FeedRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.{Repositories.FeedRepository, Repo}
  alias Reedly.Database.Test.{ValidationTestHelper, FeedTestHelper, CategoryTestHelper}

  describe "all()" do
    test "returns feeds with their entries" do
      existing_feeds =
        [
          FeedTestHelper.create(entries_count: 1),
          FeedTestHelper.create(entries_count: 2),
          FeedTestHelper.create(entries_count: 3)
        ]
        |> Enum.map(fn {:ok, feed} -> feed end)

      feeds = FeedRepository.all()

      assert FeedTestHelper.equal?(feeds, existing_feeds)
    end
  end

  describe "create/1" do
    test "creates a feed" do
      feed_attributes = FeedTestHelper.build_attributes(entries_count: 2)

      {:ok, feed} = FeedRepository.create(feed_attributes)

      assert FeedTestHelper.equal?(feed, feed_attributes)
    end

    test "returns feed_url required validation error without feed_url attribute" do
      assert ValidationTestHelper.validation_error?(FeedRepository.create(), :feed_url, :required) == true
    end

    test "returns feed_url uniqness validation error if feed_url is not unique" do
      feed_attributes = %{feed_url: Faker.Internet.url()}
      FeedRepository.create(feed_attributes)

      result = FeedRepository.create(feed_attributes)

      assert ValidationTestHelper.validation_error?(result, :feed_url, :unique) == true
    end

    test "creates feed with category" do
      {:ok, category} = CategoryTestHelper.create()

      {:ok, feed} = FeedRepository.create(%{category_id: category.id, feed_url: Faker.Internet.url()})

      assert Repo.preload(feed, [:category]).category == category
    end

    test "fails when category_id is not correct" do
      attributes = FeedTestHelper.build_attributes(%{category_id: 42})

      result = FeedRepository.create(attributes)

      assert ValidationTestHelper.validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      {:ok, category} = CategoryTestHelper.create(%{type: "link"})
      attributes = FeedTestHelper.build_attributes(%{category_id: category.id})

      result = FeedRepository.create(attributes)

      assert ValidationTestHelper.validation_error?(result, :category_id, :category_type)
    end
  end

  describe "update/2" do
    test "updates a feed" do
      {:ok, feed} = FeedTestHelper.create(entries_count: 2)

      new_feed_attributes = FeedTestHelper.build_attributes(entries_count: 2)
      {:ok, updated_feed} = FeedRepository.update(feed, new_feed_attributes)

      refute feed.title == updated_feed.title
      refute feed.updated == updated_feed.updated
      assert length(updated_feed.entries) == 4
    end

    test "updates feed category" do
      {:ok, category} = CategoryTestHelper.create()
      {:ok, feed} = FeedTestHelper.create()

      {:ok, updated_feed} = FeedRepository.update(feed, %{category_id: category.id})

      refute feed.category_id == updated_feed.category_id
    end

    test "fails when category_id is not correct" do
      {:ok, feed} = FeedTestHelper.create()

      result = FeedRepository.update(feed, %{category_id: 42})

      assert ValidationTestHelper.validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      {:ok, category} = CategoryTestHelper.create(%{type: "link"})
      {:ok, feed} = FeedTestHelper.create()

      result = FeedRepository.update(feed, %{category_id: category.id})

      assert ValidationTestHelper.validation_error?(result, :category_id, :category_type)
    end
  end
end
