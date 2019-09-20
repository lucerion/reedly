defmodule Reedly.Database.Test.FeedEntryTestFactory do
  @moduledoc "Feed entry factories for tests"

  use Reedly.Database.Test.TestFactory

  alias Reedly.Database.{Repo, FeedEntry}
  alias Reedly.Database.Test.{DateTimeTestHelper, FeedTestFactory, CategoryTestFactory}

  @attributes ~w[
    feed_id
    title
    content
    url
    entity_id
    published
    read
  ]a

  @doc "Builds feed entry attributes"
  def build_attributes do
    %{
      title: Faker.Name.title(),
      content: Faker.Lorem.paragraph(),
      url: Faker.Internet.url(),
      entity_id: Faker.Internet.slug(),
      published: DateTimeTestHelper.random_naive_date_time(truncate: :second),
      read: false
    }
  end

  @doc "Creates a feed entry"
  def create(attributes) when is_map(attributes) do
    %FeedEntry{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Repo.insert()
    |> extract_result()
    |> Repo.preload(:feed)
  end

  def create_for_category(read_count: read_count, unread_count: unread_count) do
    read_entries = create(%{read: true}, count: read_count)
    unread_entries = create(%{read: false}, count: unread_count)
    category = CategoryTestFactory.create()
    feed = FeedTestFactory.create(%{category_id: category.id}, entries: read_entries ++ unread_entries)

    %{category: category, feed: feed, read_entries: read_entries, unread_entries: unread_entries}
  end

  def create_for_category(count: count) do
    %{category: category, feed: feed} = create_for_category(read_count: 0, unread_count: count)
    %{category: category, feed: feed, entries: feed.entries}
  end
end
