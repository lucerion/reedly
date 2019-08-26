defmodule Reedly.Core.Links do
  @moduledoc "Links related business logic"

  alias Reedly.Database.{Link, Repositories.LinkRepository}

  @doc "Links by category"
  @spec fetch(map) :: list(Link.t())
  def fetch(%{category_id: category_id}), do: LinkRepository.filter_by_category(category_id)

  @doc "All links"
  def fetch(_attributes), do: LinkRepository.all()

  @spec fetch() :: list(Link.t())
  def fetch, do: fetch(%{})

  @doc "Creates a link"
  @spec create(map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes), do: LinkRepository.create(attributes)

  @doc "Updates a link"
  @spec update(map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case LinkRepository.find(id) do
      nil -> {:error, nil}
      link -> LinkRepository.update(link, attributes)
    end
  end

  @doc "Deletes a link by id"
  @spec delete(map) :: {:ok, Link.t()} | {:error, nil}
  def delete(%{id: id}) when is_integer(id) or is_binary(id) do
    case LinkRepository.find(id) do
      nil -> {:error, nil}
      link -> LinkRepository.delete(link)
    end
  end
end
