defmodule Reedly.API.Resolvers.LinkResolver do
  @moduledoc "Link resolvers"

  alias Reedly.Database.Link
  alias Reedly.Core.Links

  @type resolution :: %Absinthe.Resolution{}

  @doc "All links"
  @spec all(map, map, resolution) :: {:ok, list(Link.t())}
  def all(_parent, params, _resolution), do: {:ok, Links.all(params)}

  @doc "Create a link"
  @spec create(map, map, resolution) :: {:ok, Link.t()} | {:ok, Ecto.Changeset.t()}
  def create(_parent, params, _resolution) do
    case Links.create(params) do
      {:ok, link} -> {:ok, link}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end

  @doc "Update a link"
  @spec update(map, map, resolution) :: {:ok, Link.t()} | {:error, :not_found} | {:ok, Ecto.Changeset.t()}
  def update(_parent, params, _resolution) do
    case Links.update(params) do
      {:ok, link} -> {:ok, link}
      {:error, nil} -> {:error, :not_found}
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
    end
  end

  @doc "Delete a link"
  @spec delete(map, map, resolution) :: {:ok, Link.t()} | {:error, :not_found}
  def delete(_parent, params, _resolution) do
    case Links.delete(params) do
      {:ok, link} -> {:ok, link}
      {:error, nil} -> {:error, :not_found}
    end
  end
end
