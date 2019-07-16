defmodule Reedly.Database.Repo.Migrations.AddCategoryToFeed do
  use Ecto.Migration

  def change do
    alter table(:feeds) do
      add :category_id, references(:categories)
    end
  end
end
