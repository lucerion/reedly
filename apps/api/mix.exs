defmodule Reedly.API.MixProject do
  use Mix.Project

  def project do
    [
      app: :api,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      elixirc_paths: elixirc_paths(Mix.env()),
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Reedly.API.Application, []}
    ]
  end

  defp deps do
    [
      {:core, in_umbrella: true},
      {:plug_cowboy, "~> 2.0.0"},
      {:absinthe_plug, "~> 1.4.0"},
      {:jason, "~> 1.0.0"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/api",
      check: "cmd mix credo && mix dialyzer && mix test"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "api", "test/support"]
  defp elixirc_paths(_), do: ["lib", "api"]
end
