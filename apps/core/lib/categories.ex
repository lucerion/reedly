defmodule Reedly.Core.Categories do
  @moduledoc "Categories related business logic"

  alias Reedly.Database.{Category, Repositories.CategoryRepository}

  @type id :: integer | String.t()

  @doc "Fetches categories by criteria"
  @spec filter(map) :: list(Category.t()) | []
  def filter(attributes), do: CategoryRepository.filter(attributes)

  @doc "Creates a category"
  @spec create(map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes), do: CategoryRepository.create(attributes)

  @doc "Updates a category"
  @spec update(map) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case CategoryRepository.find(id) do
      nil -> {:error, nil}
      category -> CategoryRepository.update(category, attributes)
    end
  end

  @doc "Deletes a category by id"
  @spec delete(%{id: id}) :: {:ok, Category.t()} | {:error, nil}
  def delete(%{id: id}) do
    case CategoryRepository.find(id) do
      nil -> {:error, nil}
      category -> CategoryRepository.delete(category)
    end
  end
end
