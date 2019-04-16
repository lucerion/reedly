defmodule Reedly.Parser.Test.FeederExFeedFactory do
  @moduledoc "Factory functions for building FeederEx.Feed structs"

  alias Reedly.Parser.Test.Helpers

  def build(entries \\ []) do
    %FeederEx.Feed{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      updated: DateTime.utc_now() |> Helpers.format_date_time(),
      entries: entries
    }
  end
end
