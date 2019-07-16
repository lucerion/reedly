use Mix.Config

config :database,
  ecto_repos: [Reedly.Database.Repo]

config :database, Reedly.Database.Repo, url: System.get_env("DATABASE_URL")

import_config "#{Mix.env()}.exs"
