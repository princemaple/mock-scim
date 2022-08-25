defmodule Scim.MixProject do
  use Mix.Project

  def project do
    [
      app: :scim,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :file_system],
      mod: {Scim.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.0"},
      {:exsync, "~> 0.2", only: :dev}
    ]
  end
end
