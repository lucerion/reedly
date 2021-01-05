defmodule Reedly.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:credo, "~> 1.5.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      check: "cmd mix credo && mix dialyzer && mix test"
    ]
  end
end
