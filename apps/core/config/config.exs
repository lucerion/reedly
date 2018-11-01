use Mix.Config

config :reedly_core,
  ecto_repos: [Reedly.Core.Repo]

config :reedly_core, Reedly.Core.Repo,
  url: System.get_env("DATABASE_URL")
