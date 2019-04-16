defmodule Reedly.Core.Test.FeedAttributesFactory do
  @moduledoc "Factory functions for building Feed attributes"

  def build(entries_attributes \\ []) do
    %{
      title: Faker.Name.title(),
      description: Faker.Lorem.paragraph(),
      url: Faker.Internet.url(),
      site: Faker.Internet.url(),
      updated: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      entries: entries_attributes
    }
  end
end
