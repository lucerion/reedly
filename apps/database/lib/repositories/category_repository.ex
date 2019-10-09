defmodule Reedly.Database.Repositories.CategoryRepository do
  @moduledoc "Functions to read and change categories in the database"

  import Ecto.Query

  alias Reedly.Database.{Repo, Category}

  @type id :: integer | String.t()

  @feed_category_type "feed"

  @doc "Fetches a category by id"
  @spec find(id) :: Category.t() | nil
  def find(id), do: Repo.get(Category, id)

  @doc "Fetches categories by type"
  @spec filter(%{type: String.t()}) :: list(Category.t()) | []
  def filter(%{type: @feed_category_type}) do
    @feed_category_type
    |> filter_by_type()
    |> Repo.preload(:feeds)
  end

  def filter(%{type: type}), do: filter_by_type(type)

  def filter(_attributes), do: []

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

  defp filter_by_type(type) do
    Category
    |> where(type: ^type)
    |> Repo.all()
  end
end
