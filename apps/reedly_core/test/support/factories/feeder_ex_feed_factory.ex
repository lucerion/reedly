defmodule Reedly.Core.Test.FeederExFeedFactory do
  def build(entries \\ []) do
    %FeederEx.Feed{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      url: Faker.Internet.url(),
      entries: entries,
      updated: DateTime.utc_now() |> DateTime.to_string()
    }
  end
end
