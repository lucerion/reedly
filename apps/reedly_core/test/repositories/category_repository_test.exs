defmodule Reedly.Core.Test.CategoryRepositoryTest do
  use Reedly.Core.Test.RepoCase

  alias Reedly.Core.Repositories.CategoryRepository
  alias Reedly.Core.Test.{Helpers, CategoryHelpers, FeedHelpers}

  describe "find()" do
    test "returns category by id" do
      {:ok, new_category} = CategoryHelpers.create()

      category = CategoryRepository.find(new_category.id)

      assert new_category.id == category.id
    end

    test "returns nil when category is not found" do
      result = CategoryRepository.find(42)

      assert result == nil
    end
  end

  describe "create()" do
    test "creates a category" do
      attributes = CategoryHelpers.build_attributes()

      {:ok, category} = CategoryRepository.create(attributes)

      assert CategoryHelpers.attributes(category) == attributes
    end

    test "fails when a category without name" do
      attributes = CategoryHelpers.build_attributes(%{name: nil})

      result = CategoryRepository.create(attributes)

      assert Helpers.validation_error?(result, :name, :required)
    end

    test "fails when a category without type" do
      attributes = CategoryHelpers.build_attributes(%{type: nil})

      result = CategoryRepository.create(attributes)

      assert Helpers.validation_error?(result, :type, :required)
    end

    test "fails when a type is not correct" do
      attributes = CategoryHelpers.build_attributes(%{type: "not_allowed_type"})

      result = CategoryRepository.create(attributes)

      assert Helpers.validation_error?(result, :type, :inclusion)
    end

    test "fails when name and type is not unique" do
      attributes = CategoryHelpers.build_attributes()
      CategoryHelpers.create(attributes)

      result = CategoryRepository.create(attributes)

      assert Helpers.validation_error?(result, :name, :unique)
    end
  end

  describe "update()" do
    test "updates a category name" do
      {:ok, category} = CategoryHelpers.create()

      {:ok, updated_category} = CategoryRepository.update(category, %{name: "new_name"})

      refute category.name == updated_category.name
    end

    test "fails when a category without name" do
      {:ok, category} = CategoryHelpers.create()

      result = CategoryRepository.update(category, %{name: nil})

      assert Helpers.validation_error?(result, :name, :required)
    end

    test "fails when name is not unique" do
      {:ok, category_1} = CategoryHelpers.create()
      {:ok, category_2} = CategoryHelpers.create()

      result = CategoryRepository.update(category_1, %{name: category_2.name})

      assert Helpers.validation_error?(result, :name, :unique)
    end
  end

  describe "delete()" do
    test "deletes category" do
      {:ok, category} = CategoryHelpers.create()

      {:ok, deleted_category} = CategoryRepository.delete(category)

      assert category.id == deleted_category.id
    end

    test "deletes category by id" do
      {:ok, category} = CategoryHelpers.create()

      {:ok, deleted_category} = CategoryRepository.delete(category)

      assert category.id == deleted_category.id
    end

    test "fails when category is not found" do
      result = CategoryRepository.delete(42)

      assert result == {:error, :not_found}
    end

    test "nilify feeds ids after deletion" do
      {:ok, category} = CategoryHelpers.create()

      feeds = FeedHelpers.create(%{category_id: category.id}, count: 2)
      assert Enum.all?(feeds, &(&1.category_id != nil))

      CategoryRepository.delete(category)

      updated_feeds =
        feeds
        |> Enum.map(& &1.id)
        |> FeedHelpers.find_by_ids()

      assert Enum.all?(updated_feeds, &(&1.category_id == nil))
    end
  end
end
