defmodule Reedly.Database.Test.LinkRepositoryTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Repositories.LinkRepository
  alias Reedly.Database.Test.{ValidationTestHelper, LinkTestHelper}

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
  end

  describe "update/1" do
    test "updates a link" do
      {:ok, existing_link} = LinkTestHelper.create()

      new_attributes = %{url: "http://example.com", description: "new description"}
      {:ok, link} = LinkRepository.update(existing_link, new_attributes)

      refute link.url == existing_link.url
      refute link.description == existing_link.description
    end

    test "fails when a link without url" do
      {:ok, existing_link} = LinkTestHelper.create()

      result = LinkRepository.update(existing_link, %{url: nil, description: "new description"})

      assert ValidationTestHelper.validation_error?(result, :url, :required)
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
