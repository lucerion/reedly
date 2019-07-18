defmodule Reedly.API.Test.FeedResolverTest do
  use Reedly.API.Test.ResolverCase

  import Mock

  alias Reedly.API.Resolvers.FeedResolver
  alias Reedly.Database.Test.ValidationTestHelper

  describe "create/3" do
    test "creates a feed by feed_url", %{parent: parent, resolution: resolution} do
      feed_url = Faker.Internet.url()
      args = %{feed_url: feed_url}

      {:ok, feed} =
        with_mocks([get_mock(), parse_mock(), map_mock(args)]) do
          FeedResolver.create(parent, args, resolution)
        end

      assert feed.feed_url == feed_url
    end

    test "fails with validation error without feed_url arg", %{parent: parent, resolution: resolution} do
      args = %{feed_url: nil}

      {:ok, changeset} =
        with_mocks([get_mock(), parse_mock(), map_mock(args)]) do
          FeedResolver.create(parent, args, resolution)
        end

      assert ValidationTestHelper.validation_error?({:error, changeset}, :feed_url, :required) == true
    end
  end

  defp get_mock,
    do: {Reedly.Core.Helpers.HTTPHelper, [], [get: fn _url -> {:ok, "body"} end]}

  defp parse_mock,
    do: {FeederEx, [], [parse: fn _body -> {:ok, %{}, "message"} end]}

  defp map_mock(attributes),
    do: {Reedly.Feeds.Mappers.FeedMapper, [], [map: fn _feed -> attributes end]}
end
