defmodule Reedly.Database.Validators.CategoryValidator do
  @moduledoc "Validates category"

  import Ecto.Changeset

  alias Reedly.Database.{Category, Repositories.CategoryRepository}

  @error_messages %{
    not_found: "not found",
    incorrect_type: "incorrect type"
  }

  @doc "Validates category allowed type"
  @spec validate_category(Ecto.Changeset.t(), String.t()) :: Ecto.Changeset.t()
  def validate_category(%Ecto.Changeset{changes: %{category_id: nil}} = changeset, _allowed_type), do: changeset

  def validate_category(%Ecto.Changeset{changes: %{category_id: category_id}} = changeset, allowed_type) do
    case CategoryRepository.find(category_id) do
      nil -> add_error(changeset, :category_id, @error_messages.not_found, validation: :category)
      category -> validate_category_allowed(changeset, category, allowed_type)
    end
  end

  def validate_category(%Ecto.Changeset{} = changeset, _allowed_type), do: changeset

  defp validate_category_allowed(changeset, %Category{type: type}, allowed_type) when type == allowed_type,
    do: changeset

  defp validate_category_allowed(changeset, _category, _allowed_type),
    do: add_error(changeset, :category_id, @error_messages.incorrect_type, validation: :category_type)
end
