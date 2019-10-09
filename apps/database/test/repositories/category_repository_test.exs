defmodule Reedly.Database.Test.CategoryRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.CategoryRepository
  alias Reedly.Database.Test.{CategoryTestHelper, CategoryTestFactory, FeedTestHelper, FeedTestFactory}

  describe "find/1" do
    test "returns category by id" do
      existing_category = CategoryTestFactory.create()

      category = CategoryRepository.find(existing_category.id)

      assert CategoryTestHelper.equal?(category, existing_category)
    end

    test "returns nil when category is not found" do
      assert CategoryRepository.find(42) == nil
    end
  end

  describe "filter/1" do
    test "returns categories by type" do
      existing_feeds_categories = CategoryTestFactory.create(%{type: "feed"}, count: 3)
      existing_links_categories = CategoryTestFactory.create(%{type: "link"}, count: 2)

      feeds_categories = CategoryRepository.filter(%{type: "feed"})
      links_categories = CategoryRepository.filter(%{type: "link"})

      assert CategoryTestHelper.equal?(feeds_categories, existing_feeds_categories)
      assert CategoryTestHelper.equal?(links_categories, existing_links_categories)
    end

    test "preloads feeds for feeds categories" do
      existing_feed_category = CategoryTestFactory.create(%{type: "feed"})
      existing_feeds = FeedTestFactory.create(%{category_id: existing_feed_category.id}, count: 3)

      feeds_categories = CategoryRepository.filter(%{type: "feed"})
      feeds = Enum.flat_map(feeds_categories, & &1.feeds)

      assert FeedTestHelper.equal?(feeds, existing_feeds)
    end

    test "returns empty list when arguments are not valid" do
      assert CategoryRepository.filter(%{type: "custom"}) == []
      assert CategoryRepository.filter(%{}) == []
    end
  end

  describe "create/1" do
    test "creates a category" do
      attributes = CategoryTestFactory.build_attributes()

      {:ok, category} = CategoryRepository.create(attributes)

      assert CategoryTestHelper.equal?(category, attributes)
    end

    test "fails when a category without name" do
      attributes = CategoryTestFactory.build_attributes(%{name: nil})

      result = CategoryRepository.create(attributes)

      assert validation_error?(result, :name, :required)
    end

    test "fails when a category without type" do
      attributes = CategoryTestFactory.build_attributes(%{type: nil})

      result = CategoryRepository.create(attributes)

      assert validation_error?(result, :type, :required)
    end

    test "fails when a type is not correct" do
      attributes = CategoryTestFactory.build_attributes(%{type: "not_allowed_type"})

      result = CategoryRepository.create(attributes)

      assert validation_error?(result, :type, :inclusion)
    end

    test "fails when name and type is not unique" do
      attributes = CategoryTestFactory.build_attributes()
      CategoryTestFactory.create(attributes)

      result = CategoryRepository.create(attributes)

      assert validation_error?(result, :name, :unique)
    end
  end

  describe "update/2" do
    test "updates a category name" do
      category = CategoryTestFactory.create()

      {:ok, updated_category} = CategoryRepository.update(category, %{name: "new_name"})

      refute category.name == updated_category.name
    end

    test "fails when a category without name" do
      category = CategoryTestFactory.create()

      result = CategoryRepository.update(category, %{name: nil})

      assert validation_error?(result, :name, :required)
    end

    test "fails when name is not unique" do
      category_1 = CategoryTestFactory.create()
      category_2 = CategoryTestFactory.create()

      result = CategoryRepository.update(category_1, %{name: category_2.name})

      assert validation_error?(result, :name, :unique)
    end
  end

  describe "delete/1" do
    test "deletes category" do
      category = CategoryTestFactory.create()

      {:ok, deleted_category} = CategoryRepository.delete(category)

      assert CategoryTestHelper.equal?(deleted_category, category)
    end

    test "nilify feeds ids after deletion" do
      category = CategoryTestFactory.create()

      feeds = FeedTestFactory.create(%{category_id: category.id}, count: 2)
      assert Enum.all?(feeds, &(&1.category_id != nil))

      CategoryRepository.delete(category)
      assert Enum.all?(updated_feeds(feeds), &(&1.category_id == nil))
    end
  end

  defp updated_feeds(feeds) do
    feeds
    |> Enum.map(& &1.id)
    |> FeedTestHelper.find_by_ids()
  end
end
