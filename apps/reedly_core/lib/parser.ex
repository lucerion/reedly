defmodule Reedly.Core.Parser do
  @moduledoc "Parses feed xml to feed attributes"

  alias Reedly.Core.Mappers.FeedMapper

  @doc "Parse xml to attributes"
  @spec parse(String.t()) :: {:ok, FeedMapper.feed_attributes()} | {:error, any}
  def parse(xml) do
    case FeederEx.parse(xml) do
      {:ok, feed, _} -> {:ok, FeedMapper.map(feed)}
      error -> error
    end
  end
end
