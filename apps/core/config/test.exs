use Mix.Config

config :core, Reedly.Core.Repo,
  url: System.get_env("TEST_DATABASE_URL"),
  pool: Ecto.Adapters.SQL.Sandbox
