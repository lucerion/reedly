defmodule Reedly.API.Resolvers.FeedResolver do
  @moduledoc "Feed resolvers"

  alias Reedly.Database.Feed
  alias Reedly.Core.Feeds

  @type resolution :: %Absinthe.Resolution{}

  @doc "All feeds"
  @spec fetch(map, map, resolution) :: {:ok, list(Feed.t())} | {:ok, []}
  def fetch(_parent, _params, _resolution), do: {:ok, Feeds.all()}

  @doc "Creates a feed with entries by feed url"
  @spec create(map, map, resolution) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(_parent, params, _resolution), do: Feeds.create(params)
end
