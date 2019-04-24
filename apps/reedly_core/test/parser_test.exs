defmodule Reedly.Core.Test.ParserTest do
  use ExUnit.Case
  import Mock

  alias Reedly.Core.Parser
  alias Reedly.Core.Test.FeederExHelpers

  describe "parse()" do
    test "returns a list of feed attributes" do
      feeder_ex_entries = [FeederExHelpers.build_entry(), FeederExHelpers.build_entry(), FeederExHelpers.build_entry()]
      feeder_ex_feed = FeederExHelpers.build_feed(feeder_ex_entries)
      feed_attributes = FeederExHelpers.to_feed_attributes(feeder_ex_feed)

      {:ok, parse_result} =
        with_mocks([success_get_url_mock(), body_parse_success(feeder_ex_feed)]) do
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
    {HTTPoison, [], [get: mock]}
  end

  defp fail_get_url_mock(error),
    do: {HTTPoison, [], [get: fn _url -> {:error, error} end]}

  defp body_parse_success(feeder_ex_feed),
    do: {FeederEx, [], [parse: fn _body -> {:ok, feeder_ex_feed, ""} end]}

  defp body_parse_failed(error),
    do: {FeederEx, [], [parse: fn _body -> {:error, error} end]}
end
