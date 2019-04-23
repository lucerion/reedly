defmodule Reedly.API.MixProject do
  use Mix.Project

  def project do
    [
      app: :reedly_api,
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
      extra_applications: [:logger],
      mod: {Reedly.API.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0.0"},
      {:absinthe_plug, "~> 1.4.0"},
      {:jason, "~> 1.0.0"}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/reedly_parser"
    ]
  end
end