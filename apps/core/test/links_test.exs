defmodule Reedly.Core.Test.LinksTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  alias Reedly.Core.Links
  alias Reedly.Database.Test.{LinkTestHelper, LinkTestFactory, CategoryTestFactory}

  describe "all/1" do
    test "returns all links" do
      existing_links = LinkTestFactory.create(count: 3)

      links = Links.all()

      assert LinkTestHelper.equal?(existing_links, links)
    end
  end

  describe "filter/1" do
    test "returns links by category when category id passed in args" do
      category_1 = CategoryTestFactory.create(%{type: "link"})
      category_2 = CategoryTestFactory.create(%{type: "link"})

      existing_category_1_links = LinkTestFactory.create(%{category_id: category_1.id}, count: 2)
      existing_category_2_links = LinkTestFactory.create(%{category_id: category_2.id}, count: 3)

      category_1_links = Links.filter(%{category_id: category_1.id})
      category_2_links = Links.filter(%{category_id: category_2.id})

      assert LinkTestHelper.equal?(category_1_links, existing_category_1_links)
      assert LinkTestHelper.equal?(category_2_links, existing_category_2_links)
    end
  end

  describe "create/1" do
    test "creates a link" do
      attributes = LinkTestFactory.build_attributes()

      {:ok, link} = Links.create(attributes)

      assert LinkTestHelper.equal?(link, attributes)
    end
  end

  describe "update/1" do
    test "updates a link" do
      existing_link = LinkTestFactory.create()

      {:ok, link} = Links.update(%{id: existing_link.id, url: "http://example.com", description: "new description"})

      refute link.url == existing_link.url
      refute link.description == existing_link.description
    end

    test "fails when a link not found" do
      assert Links.update(%{id: 42}) == {:error, nil}
    end
  end

  describe "delete/1" do
    test "deletes a link" do
      link = LinkTestFactory.create()

      {:ok, deleted_link} = Links.delete(%{id: link.id})

      assert LinkTestHelper.equal?(link, deleted_link)
    end

    test "fails when a link not found" do
      assert Links.delete(%{id: 42}) == {:error, nil}
    end
  end
end
