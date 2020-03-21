defmodule Reedly.Scheduler.MixProject do
  use Mix.Project

  def project do
    [
      app: :scheduler,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Reedly.Scheduler.Application, []}
    ]
  end

  defp deps do
    [
      {:core, in_umbrella: true},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.5.0"}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/scheduler",
      check: "cmd mix credo && mix dialyzer"
    ]
  end
end
