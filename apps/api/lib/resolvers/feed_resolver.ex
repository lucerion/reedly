defmodule Reedly.API.Resolvers.FeedResolver do
  @moduledoc "Feed resolvers"

  alias Reedly.Database.Feed
  alias Reedly.Core.Feeds

  @doc "Create a feed with entries by feed url"
  @spec create(map, map, %Absinthe.Resolution{}) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(_parent, params, _resolution), do: Feeds.create(params)
end
