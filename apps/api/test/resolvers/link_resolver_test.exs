defmodule Reedly.API.Test.LinkResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.LinkResolver
  alias Reedly.Database.Test.{LinkTestHelper, LinkTestFactory, CategoryTestFactory}

  describe "filter/3" do
    test "returns all links", %{parent: parent, args: args, resolution: resolution} do
      existing_links = LinkTestFactory.create(count: 3)

      {:ok, links} = LinkResolver.filter(parent, args, resolution)

      assert LinkTestHelper.equal?(existing_links, links)
    end

    test "returns links by category when category_id passed in args", %{parent: parent, resolution: resolution} do
      category_1 = CategoryTestFactory.create(%{type: "link"})
      category_2 = CategoryTestFactory.create(%{type: "link"})

      existing_category_1_links = LinkTestFactory.create(%{category_id: category_1.id}, count: 2)
      existing_category_2_links = LinkTestFactory.create(%{category_id: category_2.id}, count: 3)

      {:ok, category_1_links} = LinkResolver.filter(parent, %{category_id: category_1.id}, resolution)
      {:ok, category_2_links} = LinkResolver.filter(parent, %{category_id: category_2.id}, resolution)

      assert LinkTestHelper.equal?(category_1_links, existing_category_1_links)
      assert LinkTestHelper.equal?(category_2_links, existing_category_2_links)
    end
  end

  describe "create/3" do
    test "creates a link", %{parent: parent, resolution: resolution} do
      attributes = LinkTestFactory.build_attributes()

      {:ok, link} = LinkResolver.create(parent, attributes, resolution)

      assert LinkTestHelper.equal?(link, attributes)
    end
  end

  describe "update/3" do
    test "updates a link", %{parent: parent, resolution: resolution} do
      existing_link = LinkTestFactory.create()

      new_attributes = %{id: existing_link.id, url: "http://example.com", description: "new description"}
      {:ok, link} = LinkResolver.update(parent, new_attributes, resolution)

      refute link.url == existing_link.url
      refute link.description == existing_link.description
    end

    test "fails when a link not found", %{parent: parent, resolution: resolution} do
      assert LinkResolver.update(parent, %{id: 42}, resolution) == {:error, nil}
    end
  end

  describe "delete/3" do
    test "deletes a link", %{parent: parent, resolution: resolution} do
      link = LinkTestFactory.create()

      {:ok, deleted_link} = LinkResolver.delete(parent, %{id: link.id}, resolution)

      assert LinkTestHelper.equal?(link, deleted_link)
    end

    test "fails when a link not found", %{parent: parent, resolution: resolution} do
      assert LinkResolver.delete(parent, %{id: 42}, resolution) == {:error, nil}
    end
  end
end
