defmodule Reedly.Core.Categories do
  @moduledoc "Categories related business logic"

  alias Reedly.Database.{Category, Repositories.CategoryRepository}

  @doc "Categories by type"
  @spec fetch(map) :: list(Category.t())
  def fetch(%{type: type}), do: CategoryRepository.filter_by_type(type)

  @doc "All categories"
  def fetch(_attributes), do: CategoryRepository.all()

  @spec fetch() :: list(Category.t())
  def fetch, do: fetch(%{})

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
  @spec delete(map) :: {:ok, Category.t()} | {:error, nil}
  def delete(%{id: id}) when is_integer(id) or is_binary(id) do
    case CategoryRepository.find(id) do
      nil -> {:error, nil}
      category -> CategoryRepository.delete(category)
    end
  end
end
