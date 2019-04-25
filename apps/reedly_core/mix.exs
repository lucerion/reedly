defmodule Reedly.Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :reedly_core,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      elixirc_paths: elixirc_paths(Mix.env()),
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Reedly.Core.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.1.0"},
      {:postgrex, "~> 0.14.0"},
      {:jason, "~> 1.0.0"},
      {:feeder_ex, "~> 1.1.0"},
      {:httpoison, "~> 1.5.0"},
      {:timex, "~> 3.5.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:faker, "~> 0.12.0", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/reedly_core",
      setup: ["ecto.create", "ecto.migrate"],
      reset: ["ecto.drop", "setup"],
      check: "cmd mix credo && mix dialyzer && mix test"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "reedly_core", "test/support"]
  defp elixirc_paths(_), do: ["lib", "reedly_core"]
end
