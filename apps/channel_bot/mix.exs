defmodule ChannelBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :channel_bot,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ChannelBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1.0"},
      {:httpoison, "~> 1.7.0"},
      {:nadia, "~> 0.7.0"},
      {:json, "~> 1.0"}
    ]
  end
end
