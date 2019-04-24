defmodule Reedly.API.Resolvers.FeedResolver do
  @moduledoc "Feed resolvers"

  alias Reedly.Core.{Feed, Fetcher, Parser, Repositories.FeedRepository}

  @doc "Create a feed with entries by feed url"
  @spec create(map(), map(), %Absinthe.Resolution{}) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def create(_parent, %{feed_url: feed_url}, _resolution) do
    with {:ok, xml} <- Fetcher.fetch(feed_url),
         {:ok, feed_attributes} <- Parser.parse(feed_url),
         full_attributes = Map.put(feed_attributes, :feed_url, feed_url),
         {:ok, feed} <- FeedRepository.create(full_attributes) do
      {:ok, feed}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
      error -> error
    end
  end
end
