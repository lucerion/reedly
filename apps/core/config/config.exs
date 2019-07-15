use Mix.Config

config :core,
  ecto_repos: [Reedly.Core.Repo]

config :core, Reedly.Core.Repo, url: System.get_env("DATABASE_URL")

config :core, Reedly.Core.Scheduler,
  jobs: [
    update_feeds: [
      schedule: System.get_env("FEEDS_UPDATE_SCHEDULE") || "*/5 * * * *",
      task: {Reedly.Core.Feeds, :update, []}
    ]
  ]

import_config "#{Mix.env()}.exs"
