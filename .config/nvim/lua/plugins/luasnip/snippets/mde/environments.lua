---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- INLINE MATH
  s(
    { trig = "mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("$<>$", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_text }
  ),
  -- GENERIC ENVIRONMENT
  s(
    { trig = "beg", snippetType = "autosnippet" },
    fmta(
      [[
        %<>
          <>
        %
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    )
  ),
  -- EQUATION
  s(
    { trig = "dm", snippetType = "autosnippet" },
    fmta(
      [[
        $$
          <>
        $$
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- NUMBERED EQUATION
  s(
    { trig = "ddm", snippetType = "autosnippet" },
    fmta(
      [[
        $$
          \begin{equation*}
            <>
          \end{equation*}
        $$
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- SPLIT EQUATION
  s(
    { trig = "spp", snippetType = "autosnippet" },
    fmta(
      [[
        $$
          \begin{split}
            <>
          \end{split}
        $$
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- ALIGN
  s(
    { trig = "all", snippetType = "autosnippet" },
    fmta(
      [[
        $$
          \begin{align*}
            <>
          \end{align*}
        $$
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- CASES
  s(
    { trig = "css", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{cases}<>\end{cases}
      ]],
      {
        i(1),
      }
    ),
    { condition = cond.in_mathzone }
  ),
  -- DISPLAY CASES
  s(
    { trig = "dcss", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{cases}
          <>
        \end{cases}
      ]],
      {
        i(1),
      }
    ),
    { condition = cond.in_mathzone }
  ),
}
