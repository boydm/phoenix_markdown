defmodule PhoenixMarkdownTest do
  use ExUnit.Case
  alias Phoenix.View

  defmodule MyApp.PageView do
    use Phoenix.View, root: "test/fixtures/templates"

    use Phoenix.HTML
  end

  test "render a markdown template without layout" do
    html = View.render(MyApp.PageView, "sample.html", [])
    assert html == {:safe, ["" | "<h2>Sample <em>template</em> <strong>in</strong> Markdown</h2>\n"]}
  end
end

# ## Sample _template_ **in** Markdown