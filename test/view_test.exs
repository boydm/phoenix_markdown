defmodule PhoenixMarkdown.ViewTest do
  use ExUnit.Case
  alias Phoenix.View

  defmodule MyApp.PageView do
    Mix.Config.persist(phoenix_markdown: [smart_tags: false])
    use Phoenix.View, root: "test/fixtures/templates"
    use Phoenix.HTML
  end

  defmodule MyApp.SmartView do
    Mix.Config.persist(phoenix_markdown: [smart_tags: true])
    use Phoenix.View, root: "test/fixtures/templates"
    use Phoenix.HTML
  end

  #--------------------------------------------------------
  test "render a markdown template with smart tags off" do
    html = View.render(MyApp.PageView, "sample.html", [])
    assert html == {:safe, ["" | "<h2>Sample <em>template</em> <strong>in</strong> Markdown</h2>\n<p>This\nbreaks</p>\n"]}
  end

  test "render a smart markdown template with smart tags off" do
    html = View.render(MyApp.PageView, "smart_sample.html", [])
    assert html == {:safe, ["" | "<h2>Smart</h2>\n<p>&lt;% 11 + 1 %&gt;\n&lt;%= 11 + 2 %&gt;\n&lt;%% 11 + 3 %&gt;\n&lt;%# 11 + 4 %&gt;\nfin</p>\n"]}
  end

  #--------------------------------------------------------
  test "render a markdown template with smart tags on" do
    html = View.render(MyApp.SmartView, "sample.html", [])
    assert html == {:safe, ["" | "<h2>Sample <em>template</em> <strong>in</strong> Markdown</h2>\n"]}
  end

  test "render a smart markdown template with smart tags on" do
    html = View.render(MyApp.SmartView, "smart_sample.html", [])
    assert html == {:safe, [[["" | "<h2>Smart</h2>\n<p>"] | "13"] | "\nfin</p>\n"]}
  end

  test "render a regular eex template with smart tags on" do
    html = View.render(MyApp.SmartView, "regular.html", [])
    assert html == {:safe, [[["" | "<h2>Regular</h2>\n"] | "13"] | "fin"]}
  end

end