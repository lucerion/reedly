defmodule Reedly.Core.Links do
  @moduledoc "Links related business logic"

  alias Reedly.Database.{Link, Repositories.LinkRepository}

  @type id :: integer | String.t()

  @doc "Fetches all links"
  @spec all() :: list(Link.t()) | []
  def all, do: LinkRepository.all()

  @doc "Fetches links by criteria"
  @spec filter(map) :: list(Link.t()) | []
  def filter(attributes), do: LinkRepository.filter(attributes)

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
  @spec delete(%{id: id}) :: {:ok, Link.t()} | {:error, nil}
  def delete(%{id: id}) do
    case LinkRepository.find(id) do
      nil -> {:error, nil}
      link -> LinkRepository.delete(link)
    end
  end
end
