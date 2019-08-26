defmodule Reedly.Database.Test.LinkRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.LinkRepository
  alias Reedly.Database.Test.{LinkTestHelper, LinkTestFactory, CategoryTestFactory}

  describe "find/1" do
    test "returns link by id" do
      existing_link = LinkTestFactory.create()

      link = LinkRepository.find(existing_link.id)

      assert LinkTestHelper.equal?(link, existing_link)
    end
  end

  describe "all/0" do
    test "returns all links" do
      existing_links = LinkTestFactory.create(count: 3)

      links = LinkRepository.all()

      assert LinkTestHelper.equal?(existing_links, links)
    end
  end

  describe "filter_by_category/1" do
    test "returns links by category" do
      category_1 = CategoryTestFactory.create(%{type: "link"})
      category_2 = CategoryTestFactory.create(%{type: "link"})

      existing_category_1_links = LinkTestFactory.create(%{category_id: category_1.id}, count: 2)
      existing_category_2_links = LinkTestFactory.create(%{category_id: category_2.id}, count: 3)

      category_1_links = LinkRepository.filter_by_category(category_1.id)
      category_2_links = LinkRepository.filter_by_category(category_2.id)

      assert LinkTestHelper.equal?(category_1_links, existing_category_1_links)
      assert LinkTestHelper.equal?(category_2_links, existing_category_2_links)
    end

    test "preloads category for links" do
      category = CategoryTestFactory.create(%{type: "link"})
      LinkTestFactory.create(%{category_id: category.id}, count: 3)

      links = LinkRepository.filter_by_category(category.id)

      assert Enum.all?(links, fn link -> link.category == category end)
    end
  end

  describe "create/1" do
    test "creates a link" do
      attributes = LinkTestFactory.build_attributes()

      {:ok, link} = LinkRepository.create(attributes)

      assert LinkTestHelper.equal?(link, attributes)
    end

    test "fails when a link without url" do
      attributes = LinkTestFactory.build_attributes(%{url: nil})

      result = LinkRepository.create(attributes)

      assert validation_error?(result, :url, :required)
    end

    test "creates a link with category" do
      category = CategoryTestFactory.create(%{type: "link"})
      attributes = LinkTestFactory.build_attributes(%{category_id: category.id})

      {:ok, link} = LinkRepository.create(attributes)

      assert link.category_id == category.id
    end

    test "fails when category_id is not correct" do
      attributes = LinkTestFactory.build_attributes(%{category_id: 42})

      result = LinkRepository.create(attributes)

      assert validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      category = CategoryTestFactory.create()
      attributes = LinkTestFactory.build_attributes(%{category_id: category.id})

      result = LinkRepository.create(attributes)

      assert validation_error?(result, :category_id, :category_type)
    end
  end

  describe "update/1" do
    test "updates a link" do
      link = LinkTestFactory.create()

      new_attributes = %{url: "http://example.com", description: "new description"}
      {:ok, updated_link} = LinkRepository.update(link, new_attributes)

      refute updated_link.url == link.url
      refute updated_link.description == link.description
    end

    test "fails when a link without url" do
      link = LinkTestFactory.create()

      result = LinkRepository.update(link, %{url: nil, description: "new description"})

      assert validation_error?(result, :url, :required)
    end

    test "updates a link category" do
      link = LinkTestFactory.create()
      category = CategoryTestFactory.create(%{type: "link"})

      {:ok, updated_link} = LinkRepository.update(link, %{category_id: category.id})

      refute updated_link.category_id == link.category_id
    end

    test "fails when category_id is not correct" do
      link = LinkTestFactory.create()

      result = LinkRepository.update(link, %{category_id: 42})

      assert validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      category = CategoryTestFactory.create()
      link = LinkTestFactory.create()

      result = LinkRepository.update(link, %{category_id: category.id})

      assert validation_error?(result, :category_id, :category_type)
    end
  end

  describe "delete/1" do
    test "deletes a link" do
      link = LinkTestFactory.create()

      {:ok, deleted_link} = LinkRepository.delete(link)

      assert LinkTestHelper.equal?(link, deleted_link)
    end
  end
end
