defmodule Reedly.Core.Test.FeedEntryAttributesFactory do
  @moduledoc "Factory functions for building FeedEntry attributes"

  def build do
    %{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(1..3),
      url: Faker.Internet.url(),
      updated: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      read: false
    }
  end
end
