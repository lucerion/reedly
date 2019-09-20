defmodule Reedly.API.Resolvers.FeedEntryResolver do
  @moduledoc "Feed entry resolvers"

  alias Reedly.Database.FeedEntry
  alias Reedly.Core.Feeds.FeedEntries

  @type resolution :: %Absinthe.Resolution{}

  @doc "All feed entries"
  @spec fetch(map, map, resolution) :: {:ok, list(FeedEntry.t())}
  def fetch(_parent, params, _resolution) when params == %{},
    do: {:ok, FeedEntries.all()}

  @doc "Feed entries by criteria"
  def fetch(_parent, params, _resolution), do: {:ok, FeedEntries.filter(params)}

  @doc "Updates a feed entry"
  @spec update(map, map, resolution) :: {:ok, FeedEntry.t()} | {:error, nil} | {:error, Ecto.Changeset.t()}
  def update(_parent, params, _resolution), do: FeedEntries.update(params)
end
