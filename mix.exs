defmodule PhoenixMarkdown.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_markdown,
      version: "0.1.4",
      elixir: "~> 1.1",
      deps: deps(),
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
      {:phoenix, ">= 1.1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:phoenix_html, ">= 2.3.0"},
      {:earmark, "~> 1.2"},         # Markdown interpreter
    ]
  end
end
