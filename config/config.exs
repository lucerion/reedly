import Config

config :database, ecto_repos: [Reedly.Database.Repo]
config :database, Reedly.Database.Repo, url: System.get_env("DATABASE_URL")

config :api,
  port: String.to_integer(System.get_env("PORT") || "3000")

config :scheduler, Reedly.Scheduler,
  jobs: [
    update_feeds: [
      schedule: System.get_env("FEEDS_UPDATE_SCHEDULE") || "*/5 * * * *",
      task: {Reedly.Core.Feeds, :update, []}
    ]
  ]

import_config "#{Mix.env()}.exs"
