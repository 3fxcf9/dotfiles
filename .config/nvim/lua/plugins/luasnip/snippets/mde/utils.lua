---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local line_begin = require("luasnip.extras.conditions.expand").line_begin
------------------------------------------------------------------------------

return {
  s({ trig = "qdd", snippetType = "autosnippet" }, {
    t("\\quad "),
  }),
  s({ trig = "qqdd", snippetType = "autosnippet" }, {
    t("\\qquad "),
  }),
  s(
    { trig = "qdt", snippetType = "autosnippet" },
    fmta([[\quad\text{<>} ]], {
      i(1),
    })
  ),
  s(
    { trig = "qdT", snippetType = "autosnippet" },
    fmta([[\quad\text{<>}\quad ]], {
      i(1),
    })
  ),
  s({ trig = "npp", snippetType = "autosnippet" }, {
    t({ "\\newpage", "" }),
  }, { condition = line_begin }),
  -- Lorem ipsum
  s(
    { trig = "lipsum" },
    fmta(
      [[
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        ]],
      {}
    ),
    { condition = line_begin }
  ),
}
