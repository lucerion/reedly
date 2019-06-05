defmodule Reedly.Core.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :title,       :string
      add :url,         :string
      add :feed_url,    :string, null: false
      add :updated,     :naive_datetime

      timestamps()
    end

    create unique_index(:feeds, :feed_url)
  end
end
