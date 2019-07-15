use Mix.Config

config :api,
  port: String.to_integer(System.get_env("PORT") || "3000")
