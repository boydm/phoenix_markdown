defmodule PhoenixMarkdown.Engine do
  @behaviour Phoenix.Template.Engine

  @doc """
  Precompiles the String file_path into a function defintion, using the EEx and Earmark engines
  """
  def compile(path, _name) do
    md = File.read!(path)
    |> Earmark.as_html!()
    
    if Application.get_env(:phoenix_markdown, :smart_tags) do
      restore_smart_tags(md)
      |> EEx.compile_string(engine: EEx.SmartEngine, file: path, line: 1)
    else
      EEx.compile_string(md, engine: Phoenix.HTML.Engine, file: path, line: 1)
    end
  end

  defp restore_smart_tags( markdown ) do
    markdown
    |> String.replace("&lt;%", "<%")
    |> String.replace("%&gt;", "%>")
  end

end
