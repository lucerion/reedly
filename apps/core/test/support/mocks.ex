defmodule Reedly.Core.Test.Mocks do
  @moduledoc "Mocks for tests"

  def feed_fetch_and_parse_mock(new_attributes),
    do: [http_helper_get_mock(), feeder_ex_parse_mock(), feed_mapper_map_mock(new_attributes)]

  defp http_helper_get_mock,
    do: {Reedly.Core.Helpers.HTTPHelper, [], [get: fn _url -> {:ok, "body"} end]}

  defp feeder_ex_parse_mock,
    do: {FeederEx, [], [parse: fn _body -> {:ok, %{}, "message"} end]}

  defp feed_mapper_map_mock(attributes),
    do: {Reedly.Core.Feeds.Mappers.FeedMapper, [], [map: fn _feed -> attributes end]}
end
