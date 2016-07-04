defmodule PhoenixMarkdown.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_markdown,
      version: "0.1.0",
      elixir: "~> 1.3",
      deps: deps,
      package: [
        contributors: ["Boyd Multerer"],
        maintainers: ["Boyd Multerer"],
        licenses: ["MIT"],
        links: %{github: "https://github.com/boydm/phoenix_markdown"}
      ],
      description: """
      Phoenix Template Engine for Markdown
      """
    ]
  end

  def application do
    [applications: [:phoenix, :earmark]]
  end

  defp deps do
    [
      {:phoenix, "~> 1.2"},
      {:phoenix_html, "~> 2.6"},
      {:earmark, git: "https://github.com/pragdave/earmark.git"},
      #{:earmark, "~> 0.2.1"},         # Markdown interpreter
    ]
  end
end
