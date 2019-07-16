defmodule Reedly.API.Resolvers.CategoryResolver do
  @moduledoc "Category resolvers"

  alias Reedly.Database.Category
  alias Reedly.Core.Categories

  @type resolution :: %Absinthe.Resolution{}

  @doc "Create a category"
  @spec create(map, map, resolution) :: {:ok, Category.t()} | {:ok, Ecto.Changeset.t()}
  def create(_parent, params, _resolution) do
    case Categories.create(params) do
      {:ok, category} -> {:ok, category}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end

  @doc "Update a category"
  @spec update(map, map, resolution) :: {:ok, Category.t()} | {:error, :not_found} | {:ok, Ecto.Changeset.t()}
  def update(_parent, params, _resolution) do
    case Categories.update(params) do
      {:ok, category} -> {:ok, category}
      {:error, nil} -> {:error, :not_found}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end

  @doc "Delete a category"
  @spec delete(map, map, resolution) :: {:ok, Category.t()} | {:error, :not_found}
  def delete(_parent, params, _resolution) do
    case Categories.delete(params) do
      {:ok, category} -> {:ok, category}
      {:error, nil} -> {:error, :not_found}
    end
  end
end
