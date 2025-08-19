---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.mathzone_detection")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- INLINE MATH
  s(
    { trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.not_in_mathzone }
  ),
  -- INLINE MATH ON NEW LINE
  s(
    { trig = "^mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("$<>$", {
      i(1),
    }),
    { condition = cond.not_in_mathzone }
  ),
  -- GENERIC ENVIRONMENT
  s(
    { trig = "beg", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        d(2, get_visual),
        rep(1),
      }
    )
  ),
  -- ENVIRONMENT WITH ONE EXTRA ARGUMENT
  s(
    { trig = "bbeg", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        d(3, get_visual),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  -- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
  s(
    { trig = "bbbeg", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}{<>}{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        i(3),
        d(4, get_visual),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  -- MATH BLOCK
  s(
    { trig = "--", snippetType = "autosnippet" },
    fmta(
      [[
        \[
            <>
        \]
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- MATH BLOCK for markdown
  s(
    { trig = "ddm", snippetType = "autosnippet" },
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
  -- EQUATION
  s(
    { trig = "dm", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{equation*}
            <>
        \end{equation*}
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
        \begin{equation*}
            \begin{split}
                <>
            \end{split}
        \end{equation*}
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
        \begin{align*}
            <>
        \end{align*}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- ITEMIZE
  s(
    { trig = "itt", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{itemize}
            \item <>
        \end{itemize}
      ]],
      {
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  -- ENUMERATE
  s(
    { trig = "enn", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{enumerate}
            \item <>
        \end{enumerate}
      ]],
      {
        i(0),
      }
    )
  ),
  -- ITEM
  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\item "),
  }, {
    condition = line_begin,
  }),
  -- FIGURE
  s(
    { trig = "fig" },
    fmta(
      [[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    ),
    { condition = line_begin }
  ),
}
