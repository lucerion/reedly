defmodule Reedly.Parser.Test do
  use ExUnit.Case
  import Mock

  alias Reedly.Parser
  alias Reedly.Parser.Test.{Helpers, FeederExEntryFactory, FeederExFeedFactory}

  describe "parse()" do
    test "returns a list of feed attributes" do
      feed_entry_1 = FeederExEntryFactory.build()
      feed_entry_2 = FeederExEntryFactory.build()
      feed_entry_3 = FeederExEntryFactory.build()
      feed_entries = [feed_entry_1, feed_entry_2, feed_entry_3]
      feed = FeederExFeedFactory.build(feed_entries)
      feed_attributes = Helpers.feed_attributes(feed)

      {:ok, parse_result} =
        with_mocks([success_get_url_mock(), body_parse_success(feed)]) do
          Parser.parse(Faker.Internet.url())
        end

      assert parse_result == feed_attributes
    end

    test "returns an error with invalid feed URL" do
      error = "get url error message"

      {_, parse_result} =
        with_mocks([fail_get_url_mock(error)]) do
          Parser.parse(Faker.Internet.url())
        end

      assert parse_result == error
    end

    test "returns an error with invalid response body" do
      error = "body parse error message"

      {_, parse_result} =
        with_mocks([success_get_url_mock(), body_parse_failed(error)]) do
          Parser.parse(Faker.Internet.url())
        end

      assert parse_result == error
    end
  end

  defp success_get_url_mock do
    mock = fn _url -> {:ok, %HTTPoison.Response{body: Faker.Lorem.paragraph()}} end
    {HTTPoison, [], [start: fn -> {:ok, []} end, get: mock]}
  end

  defp fail_get_url_mock(error),
    do: {HTTPoison, [], [start: fn -> {:ok, []} end, get: fn _url -> {:error, error} end]}

  defp body_parse_success(feed),
    do: {FeederEx, [], [parse: fn _body -> {:ok, feed, ""} end]}

  defp body_parse_failed(error),
    do: {FeederEx, [], [parse: fn _body -> {:error, error} end]}
end
