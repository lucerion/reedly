defmodule Reedly.Core.Repo.Migrations.CreateFeedEntries do
  use Ecto.Migration

  def change do
    create table(:feed_entries) do
      add :title,     :string
      add :content,   :text
      add :url,       :string
      add :entity_id, :string
      add :published, :naive_datetime
      add :read,      :boolean, default: false

      add :feed_id, references(:feeds)

      timestamps()
    end
  end
end
