defmodule Reedly.Core.Links do
  @moduledoc "Links related business logic"

  alias Reedly.Database.{Link, Repositories.LinkRepository}

  @doc "All links"
  @spec all() :: list(Link.t())
  def all, do: all(%{})

  @spec all(map) :: list(Link.t())
  def all(_attributes), do: LinkRepository.all()

  @doc "Create a link"
  @spec create(map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(attributes), do: LinkRepository.create(attributes)

  @doc "Update a link"
  @spec update(map) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case LinkRepository.find(id) do
      nil -> {:error, nil}
      link -> LinkRepository.update(link, attributes)
    end
  end

  @doc "Delete a link by id"
  @spec delete(map) :: {:ok, Link.t()} | {:error, nil}
  def delete(%{id: id}) when is_integer(id) or is_binary(id) do
    case LinkRepository.find(id) do
      nil -> {:error, nil}
      link -> LinkRepository.delete(link)
    end
  end
end
