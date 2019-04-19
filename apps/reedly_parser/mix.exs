defmodule Reedly.Parser.MixProject do
  use Mix.Project

  def project do
    [
      app: :reedly_parser,
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
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.0"},
      {:feeder_ex, "~> 1.1.0"},
      {:timex, "~> 3.5.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:faker, "~> 0.12.0", only: :test}
    ]
  end

  defp aliases do
    [
      dialyzer: "cmd cd ../.. && mix dialyzer",
      credo: "cmd cd ../.. && mix credo ./apps/reedly_parser"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "reedly_parser", "test/support"]
  defp elixirc_paths(_), do: ["lib", "reedly_parser"]
end
