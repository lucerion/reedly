defmodule Reedly.Core.Test.CategoriesTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  alias Reedly.Core.Categories
  alias Reedly.Database.Test.{CategoryTestHelper, CategoryTestFactory}

  describe "filter/1" do
    test "returns categories by type when type passed in arguments" do
      existing_feeds_categories = CategoryTestFactory.create(%{type: "feed"}, count: 3)
      existing_links_categories = CategoryTestFactory.create(%{type: "link"}, count: 2)

      feeds_categories = Categories.filter(%{type: "feed"})
      links_categories = Categories.filter(%{type: "link"})

      assert CategoryTestHelper.equal?(feeds_categories, existing_feeds_categories)
      assert CategoryTestHelper.equal?(links_categories, existing_links_categories)
    end

    test "returns an empty list when attributes are invalid" do
      assert Categories.filter(%{attribute: "value"}) == []
      assert Categories.filter(%{}) == []
    end
  end

  describe "create/1" do
    test "creates a category" do
      attributes = CategoryTestFactory.build_attributes()

      {:ok, category} = Categories.create(attributes)

      assert CategoryTestHelper.equal?(category, attributes)
    end
  end

  describe "update/1" do
    test "updates a category" do
      category = CategoryTestFactory.create()

      {:ok, updated_category} = Categories.update(%{id: category.id, name: "new_name"})

      refute category.name == updated_category.name
    end

    test "fails if category not found" do
      assert Categories.update(%{id: 42, name: "new_name"}) == {:error, nil}
    end
  end

  describe "delete/1" do
    test "deletes a category" do
      category = CategoryTestFactory.create()

      {:ok, deleted_category} = Categories.delete(%{id: category.id})

      assert CategoryTestHelper.equal?(deleted_category, category)
    end

    test "fails if category not found" do
      assert Categories.delete(%{id: 42}) == {:error, nil}
    end
  end
end
