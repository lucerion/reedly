defmodule Reedly.Database.Repositories.FeedRepository do
  @moduledoc "Functions to read and change feeds in the database"

  import Ecto.Query

  alias Reedly.Database.{Repo, Feed}

  @doc "Fetches all feeds"
  @spec all() :: list(Feed.t())
  def all do
    Feed
    |> Repo.all()
    |> Repo.preload(:entries)
  end

  @doc "Creates a feed"
  @spec create(map) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Feed{}
    |> Feed.create_changeset(attributes)
    |> Repo.insert()
    |> preload_relation(:category)
  end

  @doc "Updates a feed"
  @spec update(Feed.t(), map) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def update(%Feed{} = feed, attributes) do
    feed
    |> Feed.update_changeset(attributes)
    |> Repo.update()
    |> preload_relation(:category)
  end

  defp preload_relation(result, relation) do
    case result do
      {:ok, feed} -> {:ok, Repo.preload(feed, relation)}
      error -> error
    end
  end
end
