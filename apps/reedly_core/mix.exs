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
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, "~> 0.14.0"},
      {:httpoison, "~> 1.4"},
      {:feeder_ex, "~> 1.1"},
      {:mock, "~> 0.3.0", only: :test},
      {:faker, "~> 0.11", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "reedly_core", "test/support"]
  defp elixirc_paths(_), do: ["lib", "reedly_core"]
end
