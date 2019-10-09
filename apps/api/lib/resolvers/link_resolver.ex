defmodule Reedly.API.Resolvers.LinkResolver do
  @moduledoc "Link resolvers"

  alias Reedly.Database.Link
  alias Reedly.Core.Links

  @type resolution :: %Absinthe.Resolution{}

  @doc "All links"
  @spec fetch(map, map, resolution) :: {:ok, list(Link.t())} | {:ok, []}
  def fetch(_parent, params, _resolution) when params == %{},
    do: {:ok, Links.all()}

  @doc "Links by criteria"
  def fetch(_parent, params, _resolution), do: {:ok, Links.filter(params)}

  @doc "Creates a link"
  @spec create(map, map, resolution) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(_parent, params, _resolution), do: Links.create(params)

  @doc "Updates a link"
  @spec update(map, map, resolution) :: {:ok, Link.t()} | {:error, nil} | {:error, Ecto.Changeset.t()}
  def update(_parent, params, _resolution), do: Links.update(params)

  @doc "Deletes a link"
  @spec delete(map, map, resolution) :: {:ok, Link.t()} | {:error, nil}
  def delete(_parent, params, _resolution), do: Links.delete(params)
end
