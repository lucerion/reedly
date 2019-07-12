defmodule Reedly.API.Resolvers.FeedEntryResolver do
  @moduledoc "Feed entry resolvers"

  alias Reedly.Core.{FeedEntry, FeedEntries}

  @doc "All feed entries"
  @spec all(map, map, %Absinthe.Resolution{}) :: {:ok, list(FeedEntry.t())}
  def all(_parent, params, _resolution), do: {:ok, FeedEntries.all(params)}

  @doc "Update a feed entry"
  @spec update(map, map, %Absinthe.Resolution{}) ::
          {:ok, FeedEntry.t()} | {:error, :not_found} | {:ok, Ecto.Changeset.t()}
  def update(_parent, params, _resolution) do
    case FeedEntries.update(params) do
      {:ok, feed_entry} -> {:ok, feed_entry}
      {:error, nil} -> {:error, :not_found}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end
end
