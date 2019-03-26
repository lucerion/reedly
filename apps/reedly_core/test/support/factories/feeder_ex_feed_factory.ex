defmodule Reedly.Core.Test.FeederExFeedFactory do
  @moduledoc "Factory functions for building FeederEx.Feed structs"

  def build(entries \\ []) do
    %FeederEx.Feed{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(1..3),
      link: Faker.Internet.url(),
      url: Faker.Internet.url(),
      updated: DateTime.utc_now() |> DateTime.to_string(),
      entries: entries
    }
  end
end
