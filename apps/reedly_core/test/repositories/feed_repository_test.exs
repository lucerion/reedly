defmodule Reedly.Core.Test.Repositories.FeedRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.FeedRepository
  alias Reedly.Core.Test.{Helpers, FeedHelpers, FeedEntryHelpers}

  describe "create()" do
    test "creates a feed record" do
      feed_entry_attribute_1 = FeedEntryHelpers.build_attributes()
      feed_entry_attribute_2 = FeedEntryHelpers.build_attributes()
      feed_entries_attributes = [feed_entry_attribute_1, feed_entry_attribute_2]
      feed_attributes = FeedHelpers.build_attributes(feed_entries_attributes)

      {:ok, feed} = FeedRepository.create(feed_attributes)

      assert FeedHelpers.attributes(feed) == feed_attributes
    end

    test "returns feed_url required validation error without feed_url attribute" do
      assert Helpers.validation_error?(FeedRepository.create(), :feed_url, :required) == true
    end

    test "returns feed_url uniqness validation error if feed_url is not unique" do
      feed_attributes = %{feed_url: Faker.Internet.url()}
      FeedRepository.create(feed_attributes)

      result = FeedRepository.create(feed_attributes)

      assert Helpers.validation_error?(result, :feed_url, :unique) == true
    end
  end
end
