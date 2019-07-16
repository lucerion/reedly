defmodule Reedly.Core.Test.LinksTest do
  use ExUnit.Case
  use Reedly.Database.Test.RepoCase

  alias Reedly.Core.Links
  alias Reedly.Database.Test.LinkTestHelper

  describe "all/1" do
    test "returns all links" do
      existing_links = LinkTestHelper.create(count: 3)

      links = Links.all()

      assert LinkTestHelper.equal?(existing_links, links)
    end
  end

  describe "create/1" do
    test "creates a link" do
      attributes = LinkTestHelper.build_attributes()

      {:ok, link} = Links.create(attributes)

      assert LinkTestHelper.equal?(link, attributes)
    end
  end

  describe "update/1" do
    test "updates a link" do
      {:ok, existing_link} = LinkTestHelper.create()

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
      {:ok, link} = LinkTestHelper.create()

      {:ok, deleted_link} = Links.delete(%{id: link.id})

      assert LinkTestHelper.equal?(link, deleted_link)
    end

    test "fails when a link not found" do
      assert Links.delete(%{id: 42}) == {:error, nil}
    end
  end
end
