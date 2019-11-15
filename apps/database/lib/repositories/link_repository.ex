defmodule Reedly.Database.Repositories.LinkRepository do
  @moduledoc "Functions to read and change links in the database"

  import Ecto.Query

  alias Reedly.Database.{Repo, Link}

  @type id :: integer | String.t()

  @doc "Fetches a link by id"
  @spec find(id) :: Link.t() | nil
  def find(id), do: Repo.get(Link, id)

  @doc "Fetches all links"
  @spec all :: list(Link.t()) | []
  def all, do: fetch(Link)

  @doc "Fetches links by category"
  @spec filter(%{category_id: id}) :: list(Link.t()) | []
  def filter(%{category_id: category_id}) do
    Link
    |> where(category_id: ^category_id)
    |> fetch()
  end

  def filter(_attributes), do: []

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

  defp fetch(query) do
    query
    |> Repo.all()
    |> Repo.preload(:category)
  end
end
