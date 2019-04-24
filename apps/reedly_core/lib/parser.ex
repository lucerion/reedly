defmodule Reedly.Core.Parser do
  @moduledoc "Feed parser gets feed by URL, parses the response and converts it to the feed attributes"

  alias Reedly.Core.{Fetcher, Mappers.FeedMapper}

  @doc "Parses feed by url"
  @spec parse(String.t()) :: {:ok, FeedMapper.feed_attributes()} | {:error, any}
  def parse(url) do
    with {:ok, xml} <- Fetcher.fetch(url),
         {:ok, feed, _} <- FeederEx.parse(xml) do
      {:ok, FeedMapper.map(feed)}
    else
      error -> error
    end
  end
end
