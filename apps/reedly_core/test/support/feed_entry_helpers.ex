defmodule Reedly.Core.Test.FeedEntryHelpers do
  @moduledoc "Test helpers functions FeedEntry"

  alias Reedly.Core.{Repo, FeedEntry}

  @attributes ~w[
    title
    content
    url
    entity_id
    published
    read
  ]a

  def attributes(feed_entry) when is_list(feed_entry),
    do: Enum.map(feed_entry, &attributes(&1))

  def attributes(feed_entry),
    do: Map.take(feed_entry, @attributes)

  def build_attributes do
    %{
      title: Faker.Name.title(),
      content: Faker.Lorem.paragraph(),
      url: Faker.Internet.url(),
      entity_id: Faker.Internet.slug(),
      published: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      read: false
    }
  end

  def create(attributes \\ %{}) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %FeedEntry{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Repo.insert()
  end
end
