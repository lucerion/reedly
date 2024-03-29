defmodule Reedly.API.Resolvers.CategoryResolver do
  @moduledoc "Category resolvers"

  alias Reedly.Database.Category
  alias Reedly.Core.Categories

  @type resolution :: %Absinthe.Resolution{}

  @doc "Creates a category"
  @spec create(map, map, resolution) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
  def create(_parent, params, _resolution), do: Categories.create(params)

  @doc "Updates a category"
  @spec update(map, map, resolution) :: {:ok, Category.t()} | {:error, nil} | {:error, Ecto.Changeset.t()}
  def update(_parent, params, _resolution), do: Categories.update(params)

  @doc "Deletes a category"
  @spec delete(map, map, resolution) :: {:ok, Category.t()} | {:error, nil}
  def delete(_parent, params, _resolution), do: Categories.delete(params)
end
