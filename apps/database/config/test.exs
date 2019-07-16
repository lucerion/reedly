use Mix.Config

config :database, Reedly.Database.Repo,
  url: System.get_env("TEST_DATABASE_URL"),
  pool: Ecto.Adapters.SQL.Sandbox
