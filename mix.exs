defmodule PhoenixMarkdown.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_markdown,
      version: "0.1.2",
      elixir: "~> 1.0.1",
      deps: deps,
      package: [
        contributors: ["Boyd Multerer"],
        maintainers: ["Boyd Multerer"],
        licenses: ["MIT"],
        links: %{github: "https://github.com/boydm/phoenix_markdown"}
      ],
      description: """
      Phoenix Template Engine for Markdown. Uses Earmark to render.
      """
    ]
  end

  def application do
    [applications: [:phoenix]]
  end

  defp deps do
    [
      {:phoenix, "~> 1.1"},
      {:phoenix_html, "~> 2.3"},
      {:earmark, "~> 1.0.1"},         # Markdown interpreter
    ]
  end
end
