defmodule Reedly.API.Resolvers.FeedEntryResolver do
  @moduledoc "Feed entry resolvers"

  alias Reedly.Database.FeedEntry
  alias Reedly.Core.Feeds.FeedEntries

  @type resolution :: %Absinthe.Resolution{}

  @doc "All feed entries"
  @spec all(map, map, resolution) :: {:ok, list(FeedEntry.t())}
  def all(_parent, params, _resolution), do: {:ok, FeedEntries.all(params)}

  @doc "Update a feed entry"
  @spec update(map, map, resolution) :: {:ok, FeedEntry.t()} | {:error, nil} | {:error, Ecto.Changeset.t()}
  def update(_parent, params, _resolution), do: FeedEntries.update(params)
end
