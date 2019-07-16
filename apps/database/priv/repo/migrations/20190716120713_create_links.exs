defmodule Reedly.Database.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url,         :string, null: false
      add :description, :string
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
