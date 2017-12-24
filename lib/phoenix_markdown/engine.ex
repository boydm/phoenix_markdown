defmodule PhoenixMarkdown.Engine do
  @behaviour Phoenix.Template.Engine

  @doc """
  Precompiles the String file_path into a function defintion, using the EEx and Earmark engines
  """
  def compile(path, name) do
    File.read!(path)
    |> Earmark.as_html!()
    |> handle_smart_tags( name )
    |> EEx.compile_string( engine: Phoenix.HTML.Engine, file: path, line: 1 )
  end

  defp handle_smart_tags( markdown, name ) do

    opt = case Application.get_env(:phoenix_markdown, :smart_tags) do
      true -> true
      :all -> true
      {:only, names}     -> Enum.member?(names, name)
      [{:only, names}]   -> Enum.member?(names, name)
      {:except, names}   -> !Enum.member?(names, name)
      [{:except, names}] -> !Enum.member?(names, name)
      _ -> false
    end

    do_restore_smart_tags( markdown, opt )
  end

  defp do_restore_smart_tags( markdown, true ) do
    markdown
    |> String.replace("&lt;%", "<%")
    |> String.replace("%&gt;", "%>")
  end
  defp do_restore_smart_tags( markdown, _ ), do: markdown

end
