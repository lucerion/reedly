defmodule Reedly.API.Resolvers.FeedResolver do
  @moduledoc "Feed resolvers"

  alias Reedly.Core.{Feed, Feeds}

  @doc "Create a feed with entries by feed url"
  @spec create(map(), map(), %Absinthe.Resolution{}) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def create(_parent, params, _resolution) do
    case Feeds.create(params) do
      {:ok, feed} -> {:ok, feed}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end
end
