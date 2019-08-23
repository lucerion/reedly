defmodule Reedly.Database.Test.CategoryValidatorTest do
  use Reedly.Database.Test.RepoCase

  alias Reedly.Database.Validators.CategoryValidator
  alias Reedly.Database.Test.CategoryTestFactory

  describe "validate_category/2" do
    test "returns changeset when category_id is nil" do
      changeset = %Ecto.Changeset{changes: %{category_id: nil}}

      validated_changeset = CategoryValidator.validate_category(changeset, "allowed_type")

      assert validated_changeset == changeset
    end

    test "returns changeset when changeset hasn't category_id" do
      changeset = %Ecto.Changeset{changes: %{}}

      validated_changeset = CategoryValidator.validate_category(changeset, "allowed_type")

      assert validated_changeset == changeset
    end

    test "adds an error when category not found" do
      changeset = %Ecto.Changeset{changes: %{category_id: 42}}

      %{errors: errors} = CategoryValidator.validate_category(changeset, "allowed_type")

      assert errors == [category_id: {"not found", [validation: :category]}]
    end

    test "adds an error when category type is not correct" do
      category = CategoryTestFactory.create(%{type: "allowed_type"})
      changeset = %Ecto.Changeset{changes: %{category_id: category.id}}

      %{errors: errors} = CategoryValidator.validate_category(changeset, "not_allowed_type")

      assert errors == [category_id: {"incorrect type", [validation: :category_type]}]
    end
  end
end
