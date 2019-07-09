use Mix.Config

config :reedly_core,
  ecto_repos: [Reedly.Core.Repo]

config :reedly_core, Reedly.Core.Repo, url: System.get_env("DATABASE_URL")

config :reedly_core, Reedly.Core.Scheduler,
  jobs: [
    update_feeds: [
      schedule: System.get_env("FEEDS_UPDATE_SCHEDULE") || "*/5 * * * *",
      task: {Reedly.Core.Feeds, :update, []}
    ]
  ]

import_config "#{Mix.env()}.exs"
