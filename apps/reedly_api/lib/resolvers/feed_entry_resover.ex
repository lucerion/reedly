defmodule Reedly.API.Resolvers.FeedEntryResolver do
  @moduledoc "Feed entry resolvers"

  alias Reedly.Core.{FeedEntry, FeedEntries}

  @doc "All feed entries"
  @spec all(map(), map(), %Absinthe.Resolution{}) :: {:ok, list(FeedEntry.t())}
  def all(_parent, params, _resolution), do: {:ok, FeedEntries.all(params)}
end
