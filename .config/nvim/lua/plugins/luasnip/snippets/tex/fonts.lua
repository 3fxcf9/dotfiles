---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- REGULAR TEXT i.e. \text (in math environments)
  s(
    { trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\text{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- TYPEWRITER i.e. \texttt
  s(
    { trig = "([^%a])txtt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("<>\\texttt{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.not_in_mathzone }
  ),
  -- ITALIC i.e. \textit
  s(
    { trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\textit{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BOLD i.e. \textbf
  s(
    { trig = "tbb", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  -- MATH ROMAN i.e. \mathrm
  s(
    { trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathrm{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH CALIGRAPHY i.e. \mathcal
  s(
    { trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathcal{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH BOLDFACE i.e. \mathbf
  s(
    { trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathbf{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH BLACKBOARD i.e. \mathbb
  s(
    { trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathbb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
