use Mix.Config

config :core, Reedly.Core.Scheduler,
  jobs: [
    update_feeds: [
      schedule: System.get_env("FEEDS_UPDATE_SCHEDULE") || "*/5 * * * *",
      task: {Reedly.Core.Feeds, :update, []}
    ]
  ]
