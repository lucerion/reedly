defmodule Reedly.API.Test.FeedResolverTest do
  use ExUnit.Case
  use Reedly.Core.Test.RepoCase
  import Mock

  alias Reedly.API.Resolvers.FeedResolver
  alias Reedly.Core.Test.Helpers

  describe "create()" do
    test "creates a feed by feed_url" do
      feed_url = Faker.Internet.url()
      args = %{feed_url: feed_url}

      {:ok, feed} =
        with_mocks([get_success_mock(), parse_success_mock()]) do
          FeedResolver.create(nil, args, nil)
        end

      assert feed.feed_url == feed_url
    end

    test "fails with validation error without feed_url arg" do
      args = %{feed_url: nil}

      {:ok, changeset} =
        with_mocks([get_success_mock(), parse_success_mock()]) do
          FeedResolver.create(nil, args, nil)
        end

      assert Helpers.validation_error?({:error, changeset}, :feed_url, :required) == true
    end

    test "fails if url fetch is failed" do
      args = %{feed_url: Faker.Internet.url()}
      error_message = "url_fetch_error_message"

      {:error, message} =
        with_mocks([get_failed_mock(error_message)]) do
          FeedResolver.create(nil, args, nil)
        end

      assert message == error_message
    end

    test "fails if xml parsing is failed" do
      args = %{feed_url: Faker.Internet.url()}
      error_message = "xml_parsing_error_message"

      {:error, message} =
        with_mocks([get_success_mock(), parse_failed_mock(error_message)]) do
          FeedResolver.create(nil, args, nil)
        end

      assert message == error_message
    end
  end

  defp get_success_mock do
    mock = fn _url -> {:ok, %HTTPoison.Response{body: Faker.Lorem.paragraph()}} end
    {HTTPoison, [], [get: mock]}
  end

  defp get_failed_mock(error) do
    {HTTPoison, [], [get: fn _url -> {:error, error} end]}
  end

  defp parse_success_mock do
    mock = fn _feed_url -> {:ok, %{}} end
    {Reedly.Core.Parser, [], [parse: mock]}
  end

  defp parse_failed_mock(error_message) do
    mock = fn _feed_url -> {:error, error_message} end
    {Reedly.Core.Parser, [], [parse: mock]}
  end
end
