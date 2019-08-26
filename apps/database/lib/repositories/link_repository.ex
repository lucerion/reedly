defmodule Reedly.Database.Repositories.LinkRepository do
  @moduledoc "Functions to read and change links in the database"

  alias Reedly.Database.{Repo, Link}

  @doc "Fetches a link by id"
  @spec find(integer | String.t()) :: Link.t() | nil
  def find(id), do: Repo.get(Link, id)

  @doc "Fetches all links"
  @spec all :: list(Link.t())
  def all, do: Repo.all(Link)

  @doc "Creates a link"
  @spec create(map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Link{}
    |> Link.changeset(attributes)
    |> Repo.insert()
  end

  @doc "Updates a link"
  @spec update(Link.t(), map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def update(%Link{} = link, attributes) do
    link
    |> Link.changeset(attributes)
    |> Repo.update()
  end

  @doc "Deletes a link"
  @spec delete(Link.t()) :: {:ok, Link.t()}
  def delete(%Link{} = link), do: Repo.delete(link)
end
