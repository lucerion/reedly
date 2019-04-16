defmodule Reedly.Core.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :title,       :string
      add :description, :text
      add :url,         :string
      add :site,        :string
      add :updated,     :naive_datetime

      timestamps()
    end
  end
end
