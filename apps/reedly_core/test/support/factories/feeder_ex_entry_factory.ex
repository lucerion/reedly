defmodule Reedly.Core.Test.FeederExEntryFactory do
  @moduledoc "Factory functions for building FeederEx.Entry structs"

  def build do
    %FeederEx.Entry{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      updated: DateTime.utc_now() |> DateTime.to_string()
    }
  end
end
