defmodule Reedly.API.Resolvers.FeedEntryResolver do
  @moduledoc "Feed entry resolvers"

  alias Reedly.Core.{Repositories.FeedEntryRepository, FeedEntry}

  @spec all(map(), map(), %Absinthe.Resolution{}) :: {:ok, list(FeedEntry.t())}
  def all(_parent, _args, _resolution), do: {:ok, FeedEntryRepository.all()}
end
