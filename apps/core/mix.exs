defmodule Reedly.Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:database, in_umbrella: true},
      {:httpoison, "~> 1.5.0"},
      {:feeder_ex, "~> 1.1.0"},
      {:faker, "~> 0.12.0", only: :test},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/core",
      check: "cmd mix credo && mix dialyzer && mix test"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "core", "test/support"]
  defp elixirc_paths(_), do: ["lib", "core"]
end
