defmodule Reedly.Database.Repositories.CategoryRepository do
  @moduledoc "Functions to read and change categories in the database"

  alias Reedly.Database.{Repo, Category}

  @doc "Fetches a category by id"
  @spec find(Category.id()) :: Category.t() | nil
  def find(id), do: Repo.get(Category, id)

  @doc "Creates a category"
  @spec create(Category.create_attributes()) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes) do
    %Category{}
    |> Category.create_changeset(attributes)
    |> Repo.insert()
  end

  @doc "Updates a category"
  @spec update(Category.t(), Category.update_attributes()) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def update(%Category{} = category, attributes) do
    category
    |> Category.update_changeset(attributes)
    |> Repo.update()
  end

  @doc "Deletes a category"
  @spec delete(Category.t()) :: {:ok, Category.t()}
  def delete(%Category{} = category), do: Repo.delete(category)
end
