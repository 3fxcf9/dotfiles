---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- REGULAR TEXT i.e. \text (in math environments)
  s(
    { trig = "tt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- MATH ROMAN i.e. \mathrm
  s(
    { trig = "rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathrm{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- MATH CALIGRAPHY i.e. \mathcal
  s(
    { trig = "mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathcal{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- MATH BOLDFACE i.e. \mathbf
  s(
    { trig = "mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- MATH BLACKBOARD i.e. \mathbb
  s(
    { trig = "mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
}
