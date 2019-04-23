use Mix.Config

config :reedly_api,
  port: String.to_integer(System.get_env("PORT") || "3000")
