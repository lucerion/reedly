defmodule Reedly.Core.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :type, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:name, :type], name: :categories_name_type_index)
  end
end
