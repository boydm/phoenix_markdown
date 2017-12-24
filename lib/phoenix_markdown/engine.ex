defmodule PhoenixMarkdown.Engine do
  @behaviour Phoenix.Template.Engine

  @doc """
  Precompiles the String file_path into a function defintion, using the EEx and Earmark engines
  """
  def compile(path, name) do

    IO.puts("md_engine path: #{path}, name: #{name}")

    File.read!(path)
    |> Earmark.as_html!()
    |> handle_smart_tags()
    |> EEx.compile_string( engine: Phoenix.HTML.Engine, file: path, line: 1 )
  end

  defp handle_smart_tags( markdown ) do
    do_restore_smart_tags( markdown, Application.get_env(:phoenix_markdown, :smart_tags) )
  end

  defp do_restore_smart_tags( markdown, true ) do
    markdown
    |> String.replace("&lt;%", "<%")
    |> String.replace("%&gt;", "%>")
  end
  defp do_restore_smart_tags( markdown, _ ), do: markdown

end
