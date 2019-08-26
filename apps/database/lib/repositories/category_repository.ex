defmodule Reedly.Database.Repositories.CategoryRepository do
  @moduledoc "Functions to read and change categories in the database"

  import Ecto.Query

  alias Reedly.Database.{Repo, Category}

  @doc "Fetches a category by id"
  @spec find(integer | String.t()) :: Category.t() | nil
  def find(id), do: Repo.get(Category, id)

  @doc "Fetches all categories"
  @spec all() :: list(Category.t())
  def all do
    Category
    |> Repo.all()
    |> Repo.preload(:feeds)
  end

  @doc "Fetches categories by type"
  @spec filter_by_type(String.t()) :: list(Category.t())
  def filter_by_type("feed" = type) do
    type
    |> fetch_by_type()
    |> Repo.preload(:feeds)
  end

  def filter_by_type(type), do: fetch_by_type(type)

  @doc "Creates a category"
  @spec create(map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Category{}
    |> Category.create_changeset(attributes)
    |> Repo.insert()
  end

  @doc "Updates a category"
  @spec update(Category.t(), map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def update(%Category{} = category, attributes) do
    category
    |> Category.update_changeset(attributes)
    |> Repo.update()
  end

  @doc "Deletes a category"
  @spec delete(Category.t()) :: {:ok, Category.t()}
  def delete(%Category{} = category), do: Repo.delete(category)

  defp fetch_by_type(type) do
    type
    |> by_type_query()
    |> Repo.all()
  end

  defp by_type_query(type),
    do: from(category in Category, where: category.type == ^type)
end
