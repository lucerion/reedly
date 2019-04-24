defmodule Reedly.API.Test.FeedResolverTest do
  use ExUnit.Case
  import Mock

  alias Reedly.API.Resolvers.FeedResolver

  describe "create()" do
    test "creates a feed by feed_url" do
      feed_url = Faker.Internet.url()
      args = %{feed_url: feed_url}

      {:ok, feed} =
        with_mocks([success_fetch(), success_parsing()]) do
          FeedResolver.create(nil, args, nil)
        end

      assert feed.feed_url == feed_url
    end

    test "fails with validation error without feed_url arg" do
      args = %{feed_url: nil}

      {:ok, changeset} =
        with_mocks([success_fetch(), success_parsing()]) do
          FeedResolver.create(nil, args, nil)
        end

      assert Reedly.Core.Test.Helpers.validation_error?({:error, changeset}, :feed_url, :required) == true
    end

    test "fails if url fetch is failed" do
      args = %{feed_url: Faker.Internet.url()}
      error_message = "url_fetch_error_message"

      {:error, message} =
        with_mocks([fail_fetch(error_message)]) do
          FeedResolver.create(nil, args, nil)
        end

      assert message == error_message
    end

    test "fails if xml parsing is failed" do
      args = %{feed_url: Faker.Internet.url()}
      error_message = "xml_parsing_error_message"

      {:error, message} =
        with_mocks([success_fetch(), failed_parsing(error_message)]) do
          FeedResolver.create(nil, args, nil)
        end

      assert message == error_message
    end
  end

  defp success_fetch do
    mock = fn _url -> {:ok, %HTTPoison.Response{body: Faker.Lorem.paragraph()}} end
    {HTTPoison, [], [get: mock]}
  end

  defp fail_fetch(error) do
    {HTTPoison, [], [get: fn _url -> {:error, error} end]}
  end

  defp success_parsing do
    mock = fn _feed_url -> {:ok, %{}} end
    {Reedly.Core.Parser, [], [parse: mock]}
  end

  defp failed_parsing(error_message) do
    mock = fn _feed_url -> {:error, error_message} end
    {Reedly.Core.Parser, [], [parse: mock]}
  end
end
