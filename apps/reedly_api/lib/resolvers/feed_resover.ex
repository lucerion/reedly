defmodule Reedly.API.Resolvers.FeedResolver do
  @moduledoc "Feed resolvers"

  alias Reedly.Core.{Repositories.FeedRepository, Feed}

  @spec create(map(), map(), %Absinthe.Resolution{}) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def create(_parent, %{feed_url: feed_url}, _resolution) do
    with {:ok, feed_attributes} <- Reedly.Parser.parse(feed_url),
         full_attributes = Map.put(feed_attributes, :feed_url, feed_url),
         {:ok, feed} <- FeedRepository.create(full_attributes) do
      {:ok, feed}
    else
      {:error, changeset} -> {:ok, changeset}
    end
  end
end
