---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
local line_begin_or_non_letter = function(line_to_cursor, matched_trigger)
  -- local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
  return line_begin or non_letter
end
------------------------------------------------------------------------------

return {
  -- Paired parentheses
  s({ trig = "(", wordTrig = false, snippetType = "autosnippet" }, {
    t("("),
    d(1, get_visual),
    t(")"),
  }),
  -- Paired curly braces
  s({ trig = "{", wordTrig = false, snippetType = "autosnippet" }, {
    t("{"),
    d(1, get_visual),
    t("}"),
  }),
  -- Paired square brackets
  s({ trig = "[", wordTrig = false, snippetType = "autosnippet" }, {
    t("["),
    d(1, get_visual),
    t("]"),
  }),
  -- Paired back ticks
  s({ trig = "sd", snippetType = "autosnippet" }, {
    f(function(_, snip)
      return snip.captures[1]
    end),
    t("`"),
    d(1, get_visual),
    t("`"),
  }),
  -- Paired double quotes
  s(
    { trig = '"', wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta('"<>"', {
      d(1, get_visual),
    }),
    { condition = line_begin_or_non_letter }
  ),
  -- Paired single quotes
  -- s(
  --   { trig = "'", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
  --   fmta("'<>'", {
  --     d(1, get_visual),
  --   }),
  --   { condition = line_begin_or_non_letter }
  -- ),
  -- Curly braces
  s(
    { trig = "fds", snippetType = "autosnippet" },
    fmta(
      [[
        {
          <>
        }
        ]],
      { d(1, get_visual) }
    )
  ),
  -- Square braces
  s(
    { trig = "gds", snippetType = "autosnippet" },
    fmta(
      [[
        [
          <>
        ]
        ]],
      { d(1, get_visual) }
    )
  ),
  -- em dash
  s({ trig = "~-", wordTrig = false }, { t("—") }),
}
