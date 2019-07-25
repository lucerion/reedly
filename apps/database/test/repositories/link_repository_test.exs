defmodule Reedly.Database.Test.LinkRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.LinkRepository
  alias Reedly.Database.Test.{ValidationTestHelper, LinkTestHelper, CategoryTestHelper}

  describe "find/1" do
    test "returns link by id" do
      {:ok, existing_link} = LinkTestHelper.create()

      link = LinkRepository.find(existing_link.id)

      assert LinkTestHelper.equal?(link, existing_link)
    end
  end

  describe "all()" do
    test "returns all links" do
      existing_links = LinkTestHelper.create(count: 3)

      links = LinkRepository.all()

      assert LinkTestHelper.equal?(existing_links, links)
    end
  end

  describe "create/1" do
    test "creates a link" do
      attributes = LinkTestHelper.build_attributes()

      {:ok, link} = LinkRepository.create(attributes)

      assert LinkTestHelper.equal?(link, attributes)
    end

    test "fails when a link without url" do
      attributes = LinkTestHelper.build_attributes(%{url: nil})

      result = LinkRepository.create(attributes)

      assert ValidationTestHelper.validation_error?(result, :url, :required)
    end

    test "creates a link with category" do
      {:ok, category} = CategoryTestHelper.create(%{type: "link"})
      attributes = LinkTestHelper.build_attributes(%{category_id: category.id})

      {:ok, link} = LinkRepository.create(attributes)

      assert link.category_id == category.id
    end

    test "fails when category_id is not correct" do
      attributes = LinkTestHelper.build_attributes(%{category_id: 42})

      result = LinkRepository.create(attributes)

      assert ValidationTestHelper.validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      {:ok, category} = CategoryTestHelper.create()
      attributes = LinkTestHelper.build_attributes(%{category_id: category.id})

      result = LinkRepository.create(attributes)

      assert ValidationTestHelper.validation_error?(result, :category_id, :category_type)
    end
  end

  describe "update/1" do
    test "updates a link" do
      {:ok, link} = LinkTestHelper.create()

      new_attributes = %{url: "http://example.com", description: "new description"}
      {:ok, updated_link} = LinkRepository.update(link, new_attributes)

      refute updated_link.url == link.url
      refute updated_link.description == link.description
    end

    test "fails when a link without url" do
      {:ok, link} = LinkTestHelper.create()

      result = LinkRepository.update(link, %{url: nil, description: "new description"})

      assert ValidationTestHelper.validation_error?(result, :url, :required)
    end

    test "updates a link category" do
      {:ok, link} = LinkTestHelper.create()
      {:ok, category} = CategoryTestHelper.create(%{type: "link"})

      {:ok, updated_link} = LinkRepository.update(link, %{category_id: category.id})

      refute updated_link.category_id == link.category_id
    end

    test "fails when category_id is not correct" do
      {:ok, link} = LinkTestHelper.create()

      result = LinkRepository.update(link, %{category_id: 42})

      assert ValidationTestHelper.validation_error?(result, :category_id, :category)
    end

    test "fails when category type is not correct" do
      {:ok, category} = CategoryTestHelper.create()
      {:ok, link} = LinkTestHelper.create()

      result = LinkRepository.update(link, %{category_id: category.id})

      assert ValidationTestHelper.validation_error?(result, :category_id, :category_type)
    end
  end

  describe "delete/1" do
    test "deletes a link" do
      {:ok, link} = LinkTestHelper.create()

      {:ok, deleted_link} = LinkRepository.delete(link)

      assert LinkTestHelper.equal?(link, deleted_link)
    end
  end
end
