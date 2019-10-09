defmodule Reedly.API.Test.CategoryResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.CategoryResolver
  alias Reedly.Database.Test.{CategoryTestHelper, CategoryTestFactory}

  describe "fetch/3" do
    test "returns categories by type when type passed in args", %{parent: parent, resolution: resolution} do
      existing_feeds_categories = CategoryTestFactory.create(%{type: "feed"}, count: 3)
      existing_links_categories = CategoryTestFactory.create(%{type: "link"}, count: 2)

      {:ok, feeds_categories} = CategoryResolver.fetch(parent, %{type: "feed"}, resolution)
      {:ok, links_categories} = CategoryResolver.fetch(parent, %{type: "link"}, resolution)

      assert CategoryTestHelper.equal?(feeds_categories, existing_feeds_categories)
      assert CategoryTestHelper.equal?(links_categories, existing_links_categories)
    end
  end

  describe "create/3" do
    test "creates a category", %{parent: parent, resolution: resolution} do
      attributes = CategoryTestFactory.build_attributes()

      {:ok, category} = CategoryResolver.create(parent, attributes, resolution)

      CategoryTestHelper.equal?(category, attributes)
    end
  end

  describe "update/3" do
    test "updates a category", %{parent: parent, resolution: resolution} do
      category = CategoryTestFactory.create()

      {:ok, updated_category} = CategoryResolver.update(parent, %{id: category.id, name: "new_name"}, resolution)

      refute category.name == updated_category.name
    end

    test "fails if category not found", %{parent: parent, resolution: resolution} do
      assert CategoryResolver.update(parent, %{id: 42, name: "new_name"}, resolution) == {:error, nil}
    end
  end

  describe "delete/3" do
    test "deletes a category", %{parent: parent, resolution: resolution} do
      category = CategoryTestFactory.create()

      {:ok, deleted_category} = CategoryResolver.delete(parent, %{id: category.id}, resolution)

      assert CategoryTestHelper.equal?(deleted_category, category)
    end

    test "fails if category not found", %{parent: parent, resolution: resolution} do
      assert CategoryResolver.delete(parent, %{id: 42}, resolution) == {:error, nil}
    end
  end
end
