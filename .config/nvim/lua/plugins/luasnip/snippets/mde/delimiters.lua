---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- LEFT/RIGHT PARENTHESES
  s(
    { trig = "lp", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\left(<>\\right)", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- LEFT/RIGHT SQUARE BRACES
  s(
    { trig = "lq", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\left[<>\\right]", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- LEFT/RIGHT CURLY BRACES
  s({ trig = "lc", snippetType = "autosnippet", wordTrig = true }, fmta("\\left\\{<>\\right\\}", { d(1, get_visual) })),
  -- BIG PARENTHESES
  s(
    { trig = "bp", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\big(<>\\big)", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- BIG SQUARE BRACES
  s(
    { trig = "bq", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\big[<>\\big]", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- BIG CURLY BRACES
  s(
    { trig = "bc", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\big\\{<>\\big\\}", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- ESCAPED CURLY BRACES
  s(
    { trig = "\\%{", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000 },
    fmta("\\{<>\\}", {
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- UNDERBRACE
  s(
    { trig = "uu", snippetType = "autosnippet" },
    fmta("\\underbrace{<>}_{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
}
