---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local line_begin = require("luasnip.extras.conditions.expand").line_begin
------------------------------------------------------------------------------

return {
  -- \frac
  s(
    { trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),
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
}
