defmodule Reedly.Core.Test.CategoriesTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  alias Reedly.Core.Categories
  alias Reedly.Database.Test.CategoryTestHelper

  describe "create/1" do
    test "creates a category" do
      attributes = CategoryTestHelper.build_attributes()

      {:ok, category} = Categories.create(attributes)

      assert CategoryTestHelper.attributes(category) == attributes
    end
  end

  describe "update/1" do
    test "updates a category" do
      {:ok, category} = CategoryTestHelper.create()

      {:ok, updated_category} = Categories.update(%{id: category.id, name: "new_name"})

      refute category.name == updated_category.name
    end

    test "fails if category not found" do
      result = Categories.update(%{id: 42, name: "new_name"})

      assert result == {:error, nil}
    end
  end

  describe "delete/1" do
    test "deletes a category" do
      {:ok, category} = CategoryTestHelper.create()

      {:ok, deleted_category} = Categories.delete(%{id: category.id})

      assert deleted_category.id == category.id
    end

    test "fails if category not found" do
      result = Categories.delete(%{id: 42})

      assert result == {:error, nil}
    end
  end
end
