defmodule Reedly.Parser do
  @moduledoc "Feed parser gets feed by URL, parses the response and converts it to the feed attributes"

  alias Reedly.Parser.Mappers.FeedMapper

  @doc "Parses feed by url"
  @spec parse(String.t()) :: {:ok, FeedMapper.feed_attributes()} | any
  def parse(url) do
    with {:ok, body} <- get(url),
         {:ok, feed, _} <- FeederEx.parse(body) do
      {:ok, FeedMapper.map(feed)}
    else
      error ->
        error
    end
  end

  @spec get(String.t()) :: {:ok, String.t()} | {:error, HTTPoison.Error.t()}
  defp get(url) do
    HTTPoison.start()

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body}

      error ->
        error
    end
  end
end
