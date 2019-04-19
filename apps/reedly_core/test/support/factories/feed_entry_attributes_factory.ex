defmodule Reedly.Core.Test.FeedEntryAttributesFactory do
  @moduledoc "Factory functions for building FeedEntry attributes"

  def build do
    %{
      title: Faker.Name.title(),
      content: Faker.Lorem.paragraph(),
      url: Faker.Internet.url(),
      entity_id: Faker.Internet.slug(),
      published: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      read: false
    }
  end
end
