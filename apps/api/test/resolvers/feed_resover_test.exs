defmodule Reedly.API.Test.FeedResolverTest do
  use Reedly.API.Test.ResolverCase

  import Mock

  alias Reedly.API.Resolvers.FeedResolver
  alias Reedly.Core.Test.Mocks
  alias Reedly.Database.Test.{ValidationTestHelper, FeedTestFactory, FeedTestHelper, CategoryTestFactory}

  describe "fetch/3" do
    test "returns all feeds", %{parent: parent, args: args, resolution: resolution} do
      category = CategoryTestFactory.create()

      existing_feeds = [
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 1),
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 2),
        FeedTestFactory.create(%{category_id: category.id}, entries_count: 3)
      ]

      {:ok, feeds} = FeedResolver.fetch(parent, args, resolution)

      assert FeedTestHelper.equal?(feeds, existing_feeds)
    end
  end

  describe "create/3" do
    test "creates a feed by feed_url", %{parent: parent, resolution: resolution} do
      feed_url = Faker.Internet.url()
      args = %{feed_url: feed_url}

      {:ok, feed} =
        with_mocks(Mocks.feed_fetch_and_parse_mock(args)) do
          FeedResolver.create(parent, args, resolution)
        end

      assert feed.feed_url == feed_url
    end

    test "fails with validation error without feed_url arg", %{parent: parent, resolution: resolution} do
      args = %{feed_url: nil}

      result =
        with_mocks(Mocks.feed_fetch_and_parse_mock(args)) do
          FeedResolver.create(parent, args, resolution)
        end

      assert ValidationTestHelper.validation_error?(result, :feed_url, :required) == true
    end
  end
end
