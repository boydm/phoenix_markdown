# Markdown Template Engine for Phoenix

[![Build Status](https://travis-ci.org/boydm/phoenix_markdown.svg?branch=master)](https://travis-ci.org/boydm/phoenix_markdown)
[![Hex.pm](https://img.shields.io/hexpm/v/phoenix_markdown.svg)](https://hex.pm/packages/phoenix_markdown)
[![Inline docs](http://inch-ci.org/github/boydm/phoenix_markdown.svg?branch=master)](http://inch-ci.org/github/boydm/phoenix_markdown)
[![Hex.pm](https://img.shields.io/hexpm/dw/phoenix_markdown.svg)](https://hex.pm/packages/phoenix_markdown)
[![Hex.pm](https://img.shields.io/hexpm/dt/phoenix_markdown.svg)](https://hex.pm/packages/phoenix_markdown)


A Markdown template engine for [Phoenix](http://amzn.to/2DhFCTB). It also lets you (optionally) embed EEx tags to be evaulated on the server.

[Read the blog post.](https://medium.com/@boydm/markdown-templates-in-phoenix-25721a3bc682)

> Powered by [Earmark](https://github.com/pragdave/earmark)

## Usage

1. Add `{:phoenix_markdown, "~> 1.0"}` to your deps in `mix.exs`.
2. Add the following to your Phoenix `config/config.exs`
```elixir
  config :phoenix, :template_engines,
    md: PhoenixMarkdown.Engine
```

If you are also using the [phoenix_haml](https://github.com/chrismccord/phoenix_haml) engine, then it should look like this:
```elixir
  config :phoenix, :template_engines,
    haml: PhoenixHaml.Engine,
    md:   PhoenixMarkdown.Engine
```

3. Use the `.html.md` extensions for your templates.

## Optional

Add md extension to Phoenix live reload in `config/dev.exs`

```elixir
  config :hello_phoenix, HelloPhoenix.Endpoint,
    live_reload: [
      patterns: [
        ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
        ~r{web/views/.*(ex)$},
        ~r{web/templates/.*(eex|md)$}
      ]
    ]
```

If you are also using the [phoenix_haml](https://github.com/chrismccord/phoenix_haml) engine,
then the pattern should look like this:

```elixir
  config :hello_phoenix, HelloPhoenix.Endpoint,
    live_reload: [
      patterns: [
        ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
        ~r{web/views/.*(ex)$},
        ~r{web/templates/.*(eex|haml|md)$}
      ]
    ]
```

## Optional Earmark Configuration

You can configure phoenix_markdown via two seperate configuration blocks.

The first one is,
literally, the options that will be passed to Earmark as it renders the markdown into html.

```elixir
  config :phoenix_markdown, :earmark, %{
    gfm: true,
    breaks: true
  }
```

Please read the [Earmark Documentation](https://hexdocs.pm/earmark/Earmark.html#as_html!/2) to understand
the options that can go here.

The Earmark options set here apply to all .md template files. If anybody has a good idea on how to pass
per-file options to a template complier, I'm open to suggestions.

## Optional Server Tags Configuration

The second configuration block is where you indicate if you want to evaluate EEx tags on the server
or escape them Earmark. The default is to escape in Earmark.

Example of markdown content with a server-side tag:

```markdown
  ## Before server-side content

  <%= 11 + 2 %>

  After the server-side content
```

To turn on server-side eex tags, set the `:server_tags` configuration option.

```elixir
  config :phoenix_markdown, :server_tags, :all
```

The options to turn on server tags are `:all`, `:only` and `:except`. Anything else (or not setting it at all)
leaves the tags escaped in Markdown.

* `:all` evaluates all server tags in all markdown files.
* `:only` Only files that match the pattern or patterns will be evaluated. 
  This pattern can be any of:
    * The name of the final html file: `"sample.html"`
    * The full path of the template file: `"lib/sample_web/templates/page/sample.html.md"`
    * A path with wildcards: `"**/page/**"`. This is nice as it would evaluate all files in a single directory.
    * A regex against the path: `~r/.+%%.+/`. This allows you to use a character sequence in the name as a per-file (or path) flag saying if it should be evaluated.
* `:except` Only files that do NOT match the pattern or patterns will be evaluated.
  This pattern can be any of:
    * The name of the final html file: `"sample.html"`
    * The full path of the template file: `"lib/sample_web/templates/page/sample.html.md"`
    * A path with wildcards: `"**/page/**"`. This is nice as it would prevent evaluation of all files in a single directory.
    * A regex against the path: `~r/.+%%.+/`. This allows you to use a character sequence in the name as a per-file (or path) flag saying if it not should be evaluated.

Both the `:only` and `:except` options accept either a single pattern, or a list of patterns.

  ```elixir
    config :phoenix_markdown, :server_tags, only: ~r/.+%%.+/
  ```
  or...

  ```elixir
    config :phoenix_markdown, :server_tags, only: [~r/.+%%.+/, "some_file.html"]
  ```

### Unexpected Token in Server Tags

By default Earmark replaces some characters with prettier UTF-8 versions. For
example, single and double quotes are replaced with left- and right-handed
versions.  This may break any server tag which contains a prettified character
since EEx cannot interpret them as intended. To fix this, disable smartypants
processing.

```elixir
  config :phoenix_markdown, :earmark, %{
    smartypants: false
  }
```

## Generators

There are no generators for phoenix_markdown since they wouldn't make sense. You can embed server-side
tags if you turn them on in the configuration, but otherwise just keep it static and refer to it from
an eex template.

Like this:
```elixir
  <% render("some_markdown.html") %>
```

[Markdown](https://daringfireball.net/projects/markdown/) is intended to be written by a human
in any simple text editor ( or a fancy one like [iA Writer](https://ia.net/writer) ). Just create
a file with the `.html.md` extension and drop it into the appropriate templates folder in your
phoenix application. Then you can use it just like any other template.
