defmodule Reedly.Core.Categories do
  @moduledoc "Categories related business logic"

  alias Reedly.Database.{Category, Repositories.CategoryRepository}

  @doc "Creates a category"
  @spec create(Category.create_attributes()) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes), do: CategoryRepository.create(attributes)

  @doc "Updates a category"
  @spec update(Category.update_attributes()) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case CategoryRepository.find(id) do
      nil -> {:error, nil}
      category -> CategoryRepository.update(category, attributes)
    end
  end

  @doc "Deletes a category by id"
  @spec delete(%{id: Category.id()}) :: {:ok, Category.t()} | {:error, nil}
  def delete(%{id: id}) do
    case CategoryRepository.find(id) do
      nil -> {:error, nil}
      category -> CategoryRepository.delete(category)
    end
  end
end
