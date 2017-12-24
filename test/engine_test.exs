defmodule PhoenixMarkdown.EngineTest do
  use ExUnit.Case
  alias PhoenixMarkdown.Engine

  test "compile a vanilla markdown template with smart tags turned off" do
    Mix.Config.persist(phoenix_markdown: [smart_tags: false])
    data = "test/fixtures/templates/view_test/my_app/page/sample.html.md"
    |> Engine.compile("sample.html")
    assert data == {
      :safe,
      [{:|, [], ["", "<h2>Sample <em>template</em> <strong>in</strong> Markdown</h2>\n"]}]
    }
  end

  test "compile a vanilla markdown template with smart_tags turned on" do
    Mix.Config.persist(phoenix_markdown: [smart_tags: true])
    data = "test/fixtures/templates/view_test/my_app/page/sample.html.md"
    |> Engine.compile("sample.html")
    assert data == {
      :<>,
      [{:context, EEx.Engine}, {:import, Kernel}],
      ["", "<h2>Sample <em>template</em> <strong>in</strong> Markdown</h2>\n"]
    }
  end

  test "compile a smart template with smart tags turned off" do
    Mix.Config.persist(phoenix_markdown: [smart_tags: false])
    data = "test/fixtures/templates/view_test/my_app/page/smart_sample.html.md"
    |> Engine.compile("smart_sample.html")
    assert data == {:safe,
     [{:|, [],
       ["",
        "<h2>Smart</h2>\n<p>&lt;% 11 + 1 %&gt;\n&lt;%= 11 + 2 %&gt;\n&lt;%% 11 + 3 %&gt;\n&lt;%# 11 + 4 %&gt;\nfin</p>\n"]}]}
  end

  test "compile a smart template with smart tags turned on" do
    Mix.Config.persist(phoenix_markdown: [smart_tags: true])
    data = "test/fixtures/templates/view_test/my_app/page/smart_sample.html.md"
    |> Engine.compile("smart_sample.html")
    assert data == {:<>, [context: EEx.Engine, import: Kernel],
      [{:__block__, [],
       [{:=, [],
         [{:tmp1, [], EEx.Engine},
          {:<>, [context: EEx.Engine, import: Kernel],
           [{:__block__, [],
             [{:=, [],
               [{:tmp2, [], EEx.Engine},
                {:<>, [context: EEx.Engine, import: Kernel],
                 ["", "<h2>Smart</h2>\n<p>"]}]},
              {:+, [line: 2], [11, 1]}, {:tmp2, [], EEx.Engine}]}, "\n"]}]},
        {:<>, [context: EEx.Engine, import: Kernel],
         [{:tmp1, [], EEx.Engine},
          {{:., [],
            [{:__aliases__, [alias: false], [:String, :Chars]}, :to_string]}, [],
           [{:+, [line: 3], [11, 2]}]}]}]}, "\n<% 11 + 3 %>\n\nfin</p>\n"]}
  end

end
