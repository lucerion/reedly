defmodule Reedly.API.Test.CategoryResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.CategoryResolver
  alias Reedly.Database.Test.CategoryTestHelper

  describe "create/3" do
    test "creates a category", %{parent: parent, resolution: resolution} do
      attributes = CategoryTestHelper.build_attributes()

      {:ok, category} = CategoryResolver.create(parent, attributes, resolution)

      assert CategoryTestHelper.attributes(category) == attributes
    end
  end

  describe "update/3" do
    test "updates a category", %{parent: parent, resolution: resolution} do
      {:ok, category} = CategoryTestHelper.create()

      {:ok, updated_category} = CategoryResolver.update(parent, %{id: category.id, name: "new_name"}, resolution)

      refute category.name == updated_category.name
    end

    test "fails if category not found", %{parent: parent, resolution: resolution} do
      assert CategoryResolver.update(parent, %{id: 42, name: "new_name"}, resolution) == {:error, :not_found}
    end
  end

  describe "delete/3" do
    test "deletes a category", %{parent: parent, resolution: resolution} do
      {:ok, category} = CategoryTestHelper.create()

      {:ok, deleted_category} = CategoryResolver.delete(parent, %{id: category.id}, resolution)

      assert deleted_category.id == category.id
    end

    test "fails if category not found", %{parent: parent, resolution: resolution} do
      assert CategoryResolver.delete(parent, %{id: 42}, resolution) == {:error, :not_found}
    end
  end
end
