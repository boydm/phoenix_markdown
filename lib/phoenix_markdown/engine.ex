defmodule PhoenixMarkdown.Engine do
  @behaviour Phoenix.Template.Engine

  #--------------------------------------------------------
  @doc """
  Precompiles the String file_path into a function defintion, using the EEx and Earmark engines
  """
  def compile(path, name) do
    File.read!(path)
    |> Earmark.as_html!(Application.get_env(:phoenix_markdown, :earmark) || %Earmark.Options{})
    |> handle_smart_tags( path, name )
    |> EEx.compile_string( engine: Phoenix.HTML.Engine, file: path, line: 1 )
  end

  #--------------------------------------------------------
  defp handle_smart_tags( markdown, path, name ) do

    restore = case Application.get_env(:phoenix_markdown, :server_tags) do
      :all -> true
      {:only, opt}     -> only?( opt, path, name )
      [{:only, opt}]   -> only?( opt, path, name )
      {:except, opt}   -> except?( opt, path, name )
      [{:except, opt}] -> except?( opt, path, name )
      _ -> false
    end

    do_restore_smart_tags( markdown, restore )
  end

  #--------------------------------------------------------
  defp do_restore_smart_tags( markdown, true ) do
    markdown
    |> String.replace("&lt;%", "<%")
    |> String.replace("%&gt;", "%>")
  end
  defp do_restore_smart_tags( markdown, _ ), do: markdown

  #--------------------------------------------------------
  defp only?( opt, path, name ) when is_bitstring(opt) do
    cond do
      opt == name -> true;
      true ->
        paths = Path.wildcard(opt)
        Enum.member?(paths, path)
    end
  end
  defp only?( opts, path, name ) when is_list(opts) do
    Enum.any?(opts, &only?(&1, path, name) )
  end
  # sadly there is no is_regex guard...
  defp only?(regex, path, _) do
    if Regex.regex?(regex) do
      String.match?(path, regex)
    else
      raise ArgumentError, "Invalid parameter to PhoenixMarkdown only: configuration #{inspect(regex)}"
    end
  end

  #--------------------------------------------------------
  defp except?( opt, path, name ) when is_bitstring(opt) do
    cond do
      opt == name -> false;
      true ->
        paths = Path.wildcard(opt)
        !Enum.member?(paths, path)
    end
  end
  defp except?( opts, path, name ) when is_list(opts) do
    Enum.all?(opts, &except?(&1, path, name) )
  end
  # sadly there is no is_regex guard...
  defp except?(regex, path, _) do
    if Regex.regex?(regex) do
      !String.match?(path, regex)
    else
      raise ArgumentError, "Invalid parameter to PhoenixMarkdown except: configuration #{inspect(regex)}"
    end
  end

end
