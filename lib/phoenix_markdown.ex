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

  ## Smart Tags Configuration

  The second configuration block is where you indicate if you want
  

  ## Generators

  There are no generators for phoenix_markdown since they wouldn't make sense. You can embed server-side
  tags if you turn them on in the configuration, but otherwise just keep it static and refer to it from
  a *.eex templete.

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
