defmodule Reedly.Database.Repositories.CategoryRepository do
  @moduledoc "Functions to read and change categories in the database"

  alias Reedly.Database.{Repo, Category}

  @doc "Find a category by id"
  @spec find(integer | String.t()) :: Category.t() | nil
  def find(id), do: Repo.get(Category, id)

  @doc "Create a category"
  @spec create(map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes \\ %{}) do
    %Category{}
    |> Category.create_changeset(attributes)
    |> Repo.insert()
  end

  @doc "Update a category"
  @spec update(Category.t(), map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def update(%Category{} = category, attributes) do
    category
    |> Category.update_changeset(attributes)
    |> Repo.update()
  end

  @doc "Delete a category"
  @spec delete(Category.t()) :: {:ok, Category.t()}
  def delete(%Category{} = category), do: Repo.delete(category)
end
