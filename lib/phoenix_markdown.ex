defmodule PhoenixMarkdown do

  @moduledoc """

  A Markdown template engine for Phoenix. It uses [Earmark](https://hex.pm/packages/earmark) to render
  markdown to html. It also lets you (optionally) embed EEx tags to be evaulated on the server.


  ## Usage

    1. Add `{:phoenix_markdown, "~> 1.0"}` to your deps in `mix.exs`.
    2. Add the following to your Phoenix `config/config.exs`

       ```elixir
      config :phoenix, :template_engines,
        md: PhoenixMarkdown.Engine
       ```

      If you are also using the [phoenix_haml](https://github.com/chrismccord/phoenix_haml) engine,
      then it should look like this:
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

  ## Earmark Configuration

  You can configure phoenix_markdown vie two seperate configuration blocks.

  The first one is,
  literally, the options that will be passed in to Earmark as it renders the markdown into html.

  ```elixir
    config :phoenix_markdown, :earmark, %Earmark.Options{
      gfm: true,
      breaks: true
    }
  ```

  Please read the [Earmark Documentation](https://hexdocs.pm/earmark/Earmark.html#as_html!/2) to understand
  the options that can go here.

  ## Smart Tags Configuration

  The second configuration block is where you indicate if you want to evaluate EEx smart tags on the server
  or escape them Earmark. The default is to escape code in Earmark.

  Example of markdown content with a smart tag:

  ```markdown
    ## Before server-side content

    <%= 11 + 2 %>

    After the server-side content
  ```

  To turn on server-side eex tags, set the `:smart_tags` configuration option.

  ```elixir
    config :phoenix_markdown, :smart_tags, :all
  ```

  The options turn on smart tags are `:all`, `:only` and `:except`. Anything else (or not setting it at all)
  leaves the tags excaped in Markdown.

  * `:all` evaluates all smart tags in all markdown files.
  * `:only` Only files that match the pattern or patterns will be evaluated. This pattern can be any of:
    * The name of the final html file ex: `"sample.html"`
    * The full path of the template file ex: `"lib/sample_web/templates/page/sample.html.md"`
    * a path with wildcards ex: `"**/page/**"`. This is nice as it would evaluate all files in a single directory.
    * a regex agains the path. ex: `~r/.+%%.+/`. This allows you to use a character sequence in the name as a per-file (or path) flag saying if it should be evaluated.
  * `:except` Only files that do NOT match the pattern or patterns will be evaluated. This pattern can be any of:
    * The name of the final html file ex: `"sample.html"`
    * The full path of the template file ex: `"lib/sample_web/templates/page/sample.html.md"`
    * a path with wildcards ex: `"**/page/**"`. This is nice as it would prevent evaluation of all files in a single directory.
    * a regex agains the path. ex: `~r/.+%%.+/`. This allows you to use a character sequence in the name as a per-file (or path) flag saying if it not should be evaluated.


  ## Generators

  There are no generators for phoenix_markdown since they wouldn't make sense. You can embed server-side
  tags if you turn them on in the configuration, but otherwise just keep it static and refer to it from
  a *.eex template.

  Like this:
  ```elixir
    <% render("some_markdown.md") %>
  ```

  [Markdown](https://daringfireball.net/projects/markdown/) is intended to be written by a human
  in any simple text editor ( or a fancy one like [iA Writer](https://ia.net/writer) ). Just create
  a file with the `.html.md` extension and drop it into the appropriate templates folder in your
  phoenix application. Then you can use it just like any other template.
  """



end
