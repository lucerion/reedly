defmodule Reedly.Core.Repo.Migrations.CreateFeedEntries do
  use Ecto.Migration

  def change do
    create table(:feed_entries) do
      add :title,     :string
      add :content,   :text
      add :url,       :string
      add :entity_id, :string, null: false
      add :published, :naive_datetime
      add :read,      :boolean, default: false

      add :feed_id, references(:feeds, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:feed_entries, :entity_id)
  end
end
