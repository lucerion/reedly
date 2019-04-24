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
        with_mocks([xml_parse_success(feeder_ex_feed)]) do
          Parser.parse(Faker.Internet.url())
        end

      assert parse_result == feed_attributes
    end

    test "returns an error when xml parsing is failed" do
      error = "body parse error message"

      {_, parse_result} =
        with_mocks([xml_parse_failed(error)]) do
          Parser.parse(Faker.Internet.url())
        end

      assert parse_result == error
    end
  end

  defp xml_parse_success(feeder_ex_feed),
    do: {FeederEx, [], [parse: fn _body -> {:ok, feeder_ex_feed, ""} end]}

  defp xml_parse_failed(error),
    do: {FeederEx, [], [parse: fn _body -> {:error, error} end]}
end
