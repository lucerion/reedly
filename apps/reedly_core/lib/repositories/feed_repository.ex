defmodule Reedly.Core.Repositories.FeedRepository do
  @moduledoc "Functions to read and manipulate feed"

  alias Reedly.Core.{Repo, Feed}

  @doc "Create a feed record"
  @spec create(map) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Feed{}
    |> Feed.changeset(attributes)
    |> Repo.insert()
  end
end
