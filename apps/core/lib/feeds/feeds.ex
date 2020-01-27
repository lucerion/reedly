defmodule Reedly.Core.Feeds do
  @moduledoc "Feeds related business logic"

  alias Reedly.Database.{Feed, Repositories.FeedRepository}
  alias Reedly.Core.{Feeds.Mappers.FeedMapper, Helpers.HTTPHelper}

  @doc "Fetches all feeds"
  @spec all() :: list(Feed.t()) | []
  def all, do: FeedRepository.all()

  @doc "Creates a feed"
  @spec create(%{feed_url: String.t()}) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def create(%{feed_url: feed_url}) do
    case parse(feed_url) do
      {:ok, attributes} ->
        attributes
        |> Map.put(:feed_url, feed_url)
        |> FeedRepository.create()

      error ->
        error
    end
  end

  @doc "Updates all feeds"
  @spec update() :: :ok
  def update, do: Enum.each(all(), &update(&1))

  @doc "Updates a feed"
  @spec update(Feed.t()) :: {:ok, Feed.t()} | {:error, Ecto.Changeset.t()}
  def update(%Feed{feed_url: feed_url} = feed) do
    case parse(feed_url) do
      {:ok, attributes} -> FeedRepository.update(feed, attributes)
      error -> error
    end
  end

  defp parse(feed_url) do
    with {:ok, xml} <- HTTPHelper.get(feed_url),
         {:ok, feed, _} <- FeederEx.parse(xml) do
      {:ok, FeedMapper.map(feed)}
    else
      error -> error
    end
  end
end
