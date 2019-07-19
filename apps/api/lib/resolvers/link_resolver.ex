defmodule Reedly.API.Resolvers.LinkResolver do
  @moduledoc "Link resolvers"

  alias Reedly.Database.Link
  alias Reedly.Core.Links

  @type resolution :: %Absinthe.Resolution{}

  @doc "All links"
  @spec all(map, map, resolution) :: {:ok, list(Link.t())}
  def all(_parent, params, _resolution), do: {:ok, Links.all(params)}

  @doc "Create a link"
  @spec create(map, map, resolution) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(_parent, params, _resolution), do: Links.create(params)

  @doc "Update a link"
  @spec update(map, map, resolution) :: {:ok, Link.t()} | {:error, nil} | {:error, Ecto.Changeset.t()}
  def update(_parent, params, _resolution), do: Links.update(params)

  @doc "Delete a link"
  @spec delete(map, map, resolution) :: {:ok, Link.t()} | {:error, nil}
  def delete(_parent, params, _resolution), do: Links.delete(params)
end
