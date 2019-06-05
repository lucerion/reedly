defmodule Reedly.Core.Repositories.FeedRepository do
  @moduledoc "Functions to read and manipulate feed"

  import Ecto.Query

  alias Reedly.Core.{Repo, Feed}

  @doc "All feeds"
  @spec all() :: list(Feed.t())
  def all, do: Repo.all(from(feed in Feed, preload: [:entries]))

  @doc "Create a feed"
  @spec create(map) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Feed{}
    |> Feed.create_changeset(attributes)
    |> Repo.insert()
  end

  @doc "Update a feed"
  @spec update(Feed.t(), map) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def update(%Feed{} = feed, attributes) do
    feed
    |> Feed.update_changeset(attributes)
    |> Repo.update()
  end
end
