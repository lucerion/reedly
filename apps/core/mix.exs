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
      {:database, in_umbrella: true},
      {:httpoison, "~> 1.5.0"},
      {:faker, "~> 0.12.0", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/core",
      check: "cmd mix credo && mix dialyzer && mix test"
    ]
  end
end
