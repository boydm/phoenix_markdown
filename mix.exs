defmodule PhoenixMarkdown.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @github "https://github.com/boydm/phoenix_markdown"
#  @blog_post "put link to blog post here"

  def project do
    [
      app: :phoenix_markdown,
      version: @version,
      elixir: "~> 1.1",
      deps: deps(),
      package: [
        contributors: ["Boyd Multerer"],
        maintainers: ["Boyd Multerer"],
        licenses: ["MIT"],
        links: %{
          github: @github,
#          "Blog Post" => @blog_post
        }
      ],

      name: "phoenix_markdown",
      source_url: @github,
      docs: docs(),
      description: """
      Markdown Template Engine for Phoenix. Uses Earmark to render.
      """
    ]
  end

  def application do
    [applications: [:phoenix]]
  end

  defp deps do
    [
      {:phoenix, ">= 1.1.0"},
      {:phoenix_html, ">= 2.3.0"},
      {:earmark, "~> 1.2"},         # Markdown interpreter

      # Docs dependencies
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
      {:inch_ex, ">= 0.0.0", only: :docs},
      {:credo, "~> 0.8.10", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      source_ref: "v#{@version}",
      main: "PhoenixMarkdown"
    ]
  end

end
