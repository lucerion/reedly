defmodule Reedly.Parser.Test.FeederExEntryFactory do
  @moduledoc "Factory functions for building FeederEx.Entry structs"

  alias Reedly.Parser.Test.Helpers

  def build do
    %FeederEx.Entry{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      updated: DateTime.utc_now() |> Helpers.format_date_time()
    }
  end
end
