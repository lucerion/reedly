defmodule Reedly.API.Test.LinkResolverTest do
  use Reedly.API.Test.ResolverCase

  alias Reedly.API.Resolvers.LinkResolver
  alias Reedly.Database.Test.{LinkTestHelper, LinkTestFactory}

  describe "all/3" do
    test "returns all links", %{parent: parent, args: args, resolution: resolution} do
      existing_links = LinkTestFactory.create(count: 3)

      {:ok, links} = LinkResolver.all(parent, args, resolution)

      assert LinkTestHelper.equal?(existing_links, links)
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
