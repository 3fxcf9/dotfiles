local M = {}

local ok_ts, ts = pcall(require, "vim.treesitter")

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local COMMENT = {
  comment = true,
  line_comment = true,
  block_comment = true,
  comment_environment = true,
}

local function get_node_at_cursor()
  if not ok_ts then
    return nil
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local ok, parser = pcall(ts.get_parser, bufnr, "latex")
  if not ok or not parser then
    return nil
  end

  local tree = parser:parse()[1]
  if not tree then
    return nil
  end
  local root = tree:root()
  if not root then
    return nil
  end

  -- named_descendant_for_range uses start_row,start_col,end_row,end_col
  return root:named_descendant_for_range(row, col, row, col)
end

function M.in_comment()
  if not ok_ts then
    return false
  end
  local node = get_node_at_cursor()
  while node do
    if COMMENT[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

function M.in_mathzone()
  if not ok_ts then
    return false
  end
  local node = get_node_at_cursor()
  while node do
    if node:type() == "text_mode" then
      return false
    elseif MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

function M.in_text()
  return not M.in_mathzone()
end
function M.alphanumeric(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[%w]")
end
function M.brackets(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[%)%]%}]")
end
function M.line_begin(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end
function M.letter(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[%a]")
end
function M.non_letter(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
end
function M.lowercase(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%l]")
end
function M.line_begin_or_non_letter(line_to_cursor, matched_trigger)
  return M.line_begin(line_to_cursor, matched_trigger) or M.non_letter(line_to_cursor, matched_trigger)
end
function M.in_text_and_lowercase(line_to_cursor, matched_trigger)
  return M.line_begin(line_to_cursor, matched_trigger) or M.non_letter(line_to_cursor, matched_trigger)
end
function M.letter_or_brackets_and_math(line_to_cursor, matched_trigger)
  return (
    M.brackets(line_to_cursor, matched_trigger)
    or M.letter(line_to_cursor, matched_trigger)
    or M.line_begin_or_non_letter(line_to_cursor, matched_trigger)
  ) and M.in_mathzone()
end
function M.alpha_or_brackets_and_math(line_to_cursor, matched_trigger)
  return (
    M.alphanumeric(line_to_cursor, matched_trigger)
    or M.brackets(line_to_cursor, matched_trigger)
    or M.line_begin_or_non_letter(line_to_cursor, matched_trigger)
  ) and M.in_mathzone()
end
function M.line_begin_or_non_letter_and_math(line_to_cursor, matched_trigger)
  return M.in_mathzone()
    and (M.line_begin_or_non_letter(line_to_cursor, matched_trigger) or line_to_cursor:sub(-1) == "$")
end
function M.line_begin_or_non_letter_and_text(line_to_cursor, matched_trigger)
  return M.in_text() and (M.line_begin_or_non_letter(line_to_cursor, matched_trigger) or line_to_cursor:sub(-1) == "$")
end

return M
