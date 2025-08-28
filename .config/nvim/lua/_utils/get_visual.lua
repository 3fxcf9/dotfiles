-- ~/.config/nvim/lua/luasnip/helpers.lua
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

local M = {}

-- returns a snippet node containing the visual selection (or empty insert node)
function M.get_visual(args, parent)
  -- parent may be nil in some LuaSnip call paths; be defensive
  if not parent or not parent.snippet or not parent.snippet.env then
    return ls.sn(nil, ls.i(1, "")) -- safe fallback
  end

  local raw = parent.snippet.env.LS_SELECT_RAW
  if not raw then
    return ls.sn(nil, ls.i(1, "")) -- nothing selected
  end

  -- LS_SELECT_RAW is often a table of lines; join into a string
  local text
  if type(raw) == "table" then
    text = table.concat(raw, "\n")
  else
    text = tostring(raw)
  end

  if text == "" then
    return ls.sn(nil, ls.i(1, ""))
  end

  return ls.sn(nil, ls.i(1, text))
end

return M
