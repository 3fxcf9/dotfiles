---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- SUPERSCRIPT
  s(
    { trig = "%^", wordTrig = false, regTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("^{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- SUBSCRIPT
  s(
    { trig = "_", wordTrig = false, regTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("_{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  s(
    { trig = ";", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}_{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- TEXT SUBSCRIPT
  s(
    { trig = "sd", snippetType = "autosnippet", wordTrig = false },
    fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
    { condition = cond.in_mathzone }
  ),
  -- SUPERSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a superscript.
  s(
    { trig = "'([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- SUBSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a subscript.
  s(
    { trig = "%.([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  s(
    { trig = "ee", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("e^{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.alpha_or_brackets_and_math }
  ),
  -- ZERO SUBSCRIPT SHORTCUT
  s(
    { trig = "00", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("_{<>}", {
      t("0"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- MINUS ONE SUPERSCRIPT SHORTCUT
  s(
    { trig = "11", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      t("-1"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- CROSS SUPERSCRIPT
  s(
    { trig = "XX", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      t("\\times"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- TRANSPOSITION
  s(
    { trig = "TT", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>", {
      t("\\transp"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- STAR AFTER SET
  s(
    { trig = "(\\[NZQRCK])%*", regTrig = true, wordTrig = true, snippetType = "autosnippet" },
    fmta("<>^{*}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- STAR AFTER SET (with plus)
  s(
    { trig = "(\\[NZQRCK]%_%{%+%})%*", regTrig = true, wordTrig = true, snippetType = "autosnippet" },
    fmta("<>^{*}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PLUS AFTER SET
  s(
    { trig = "(\\[NZQRK])%+", regTrig = true, wordTrig = true, snippetType = "autosnippet" },
    fmta("<>_{+}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PLUS SUPERSCRIPT SHORTCUT
  s(
    { trig = "%+%+", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      t("+"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- MINUS SUPERSCRIPT SHORTCUT
  s(
    { trig = "%-%-", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      t("-"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- COMPLEMENT SUPERSCRIPT
  -- s(
  -- 	{ trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
  -- 	fmta("<>^{<>}", {
  -- 		f(function(_, snip)
  -- 			return snip.captures[1]
  -- 		end),
  -- 		t("\\complement"),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
  -- STAR SUPERSCRIPT SHORTCUT
  s(
    { trig = "%*%*", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("^{<>}", {
      t("*"),
    }),
    { condition = cond.letter_or_brackets_and_math }
  ),
  -- VECTOR, i.e. \vec
  s(
    { trig = "vv", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\vec{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- -- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
  -- s(
  --   { trig = "ue", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
  --   fmta("\\unit{<>}", {
  --     d(1, get_visual),
  --   }),
  --   { condition = cond.line_begin_or_non_letter_and_math }
  -- ),
  -- MATRIX, i.e. \mtx
  s(
    { trig = "mt", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\mtx{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- FRACTION
  s(
    { trig = "ff", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- ANGLE
  s(
    { trig = "gg", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\ang{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- ABSOLUTE VALUE, i.e \abs
  s(
    { trig = "aa", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\abs{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- CONJUGATE, i.e \overline
  s(
    { trig = "bar", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\bar{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- NORM, i.e \norm
  s(
    { trig = "norm", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\norm{<>}", {
      i(1, "\\cdot"),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- TRIPLE NORM, i.e \opnorm
  s(
    { trig = "opnorm", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\opnorm{<>}", {
      i(1, "\\cdot"),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- INTERVALS
  s(
    { trig = "OO", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\oo{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  s(
    { trig = "OC", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\oc{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  s(
    { trig = "CO", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\co{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  s(
    { trig = "CC", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\cc{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- TILDE
  s(
    { trig = "tll", regTrig = false, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\tilde{<>}", {
      d(1, get_visual),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- SQUARE ROOT
  s(
    { trig = "sq", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\sqrt{<>}", {
      d(1, get_visual),
    }),
    {
      condition = function(line_to_cursor, matched_trigger)
        return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("[^%\\]")
          and cond.line_begin_or_non_letter_and_math(line_to_cursor, matched_trigger)
      end,
    }
  ),
  -- BINOMIAL SYMBOL
  s(
    { trig = "bnn", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\binom{<>}{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- LOGARITHM WITH BASE SUBSCRIPT
  s(
    { trig = "ll", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\log_{<>}", {
      i(1),
    }),
    {
      condition = function(line_to_cursor, matched_trigger)
        return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("[^%\\]")
          and cond.line_begin_or_non_letter_and_math(line_to_cursor, matched_trigger)
      end,
    }
  ),
  -- DERIVATIVE with denominator only
  s(
    { trig = "dV", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\dv{}{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- DERIVATIVE with numerator and denominator
  s(
    { trig = "dvv", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\dv{<>}{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "dvN", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\dvN{<>}{<>}{<>}", {
      i(1),
      i(2),
      i(3, "order"),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- PARTIAL DERIVATIVE with denominator only
  s(
    { trig = "pV", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\pdv{}{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- PARTIAL DERIVATIVE with numerator and denominator
  s(
    { trig = "pvv", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\pdv{<>}{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "pvN", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\pdvN{<>}{<>}{<>}", {
      i(1),
      i(2),
      i(3, "order"),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- SUM with lower limit
  s(
    { trig = "sM", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\sum_{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- SUM with upper and lower limit
  s(
    { trig = "smm", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\sum_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- PRODUCT with lower limit
  s(
    { trig = "pD", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\prod_{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- PRODUCT with upper and lower limit
  s(
    { trig = "pdd", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\prod_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- INTEGRAL with only lower limit
  s(
    { trig = "intT", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\int_{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- INTEGRAL with upper and lower limit
  s(
    { trig = "intt", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- INTEGRAL from positive to negative infinity
  s(
    { trig = "intt", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>}", {
      t("\\inff"),
      t("\\inff"),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),
  -- INFTY
  s({ trig = "inff", snippetType = "autosnippet" }, {
    t("\\infty"),
  }, { condition = cond.line_begin_or_non_letter_and_math }),
  -- BOXED command
  s(
    { trig = "bb", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta("\\boxed{<>}", {
      i(1),
    }),
    { condition = cond.line_begin_or_non_letter_and_math }
  ),

  --
  -- BEGIN STATIC SNIPPETS
  --

  -- GEQ
  s({ trig = "geq", snippetType = "autosnippet" }, {
    t("\\geq "),
  }, { condition = cond.in_mathzone }),
  -- LEQ
  s({ trig = "leq", snippetType = "autosnippet" }, {
    t("\\leq "),
  }, { condition = cond.in_mathzone }),
  -- ≥
  s({ trig = ">=", snippetType = "autosnippet", wordTrig = false, priority = 2000 }, {
    t("\\geq "),
  }, { condition = cond.in_mathzone }),
  -- ≤
  s({ trig = "<=", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
    t("\\leq"),
  }, { condition = cond.in_mathzone }),
  -- FORALL, i.e. \forall
  s({ trig = "ll", priority = 2000, snippetType = "autosnippet" }, {
    t("\\forall "),
  }, { condition = cond.in_mathzone }),
  -- EXISTS, i.e. \exists
  s({ trig = "ss", priority = 2000, snippetType = "autosnippet" }, {
    t("\\exists "),
  }, { condition = cond.in_mathzone }),
  -- PARTIAL DIFFERENTIAL, i.e. \partial
  s({ trig = "pp", priority = 2000, snippetType = "autosnippet" }, {
    t("\\partial "),
  }, { condition = cond.in_mathzone }),
  -- DIFFERENTIAL, i.e. \mathrm{d}
  s({ trig = "dd", priority = 2000, snippetType = "autosnippet" }, {
    t("\\dd "),
  }, { condition = cond.in_mathzone }),
  -- DIVERGENCE OPERATOR, i.e. \divergence
  s({ trig = "DI", snippetType = "autosnippet" }, {
    t("\\div "),
  }, { condition = cond.in_mathzone }),
  -- LAPLACIAN OPERATOR, i.e. \laplacian
  s({ trig = "laa", snippetType = "autosnippet" }, {
    t("\\laplacian "),
  }, { condition = cond.in_mathzone }),
  -- PARALLEL SYMBOL, i.e. \parallel
  s({ trig = "||", snippetType = "autosnippet" }, {
    t("\\parallel "),
  }, { condition = cond.in_mathzone }),
  -- GRADIENT OPERATOR, i.e. \grad
  s({ trig = "gdd", snippetType = "autosnippet" }, {
    t("\\grad "),
  }, { condition = cond.in_mathzone }),
  -- CDOTS, i.e. \cdots
  s({ trig = "cdd", snippetType = "autosnippet" }, {
    t("\\cdots"),
  }, { condition = cond.in_mathzone }),
  -- LDOTS, i.e. \ldots
  s({ trig = "ldd", snippetType = "autosnippet" }, {
    t("\\ldots"),
  }, { condition = cond.in_mathzone }),
  -- EQUIV, i.e. \equiv
  s({ trig = "evv", snippetType = "autosnippet" }, {
    t("\\equiv "),
  }, { condition = cond.in_mathzone }),
  -- SETMINUS, i.e. \setminus
  s({ trig = "stm", snippetType = "autosnippet" }, {
    t("\\setminus "),
  }, { condition = cond.in_mathzone }),
  -- SUBSET, i.e. \subset
  s({ trig = "sbb", snippetType = "autosnippet" }, {
    t("\\subset "),
  }, { condition = cond.in_mathzone }),
  -- SUBSETEQ, i.e., \subseteq
  s({ trig = "sbq", snippetType = "autosnippet" }, {
    t("\\subseteq "),
  }, { condition = cond.in_mathzone }),
  -- APPROX, i.e. \approx
  s({ trig = "px", snippetType = "autosnippet" }, {
    t("\\approx "),
  }, { condition = cond.in_mathzone }),
  -- PROPTO, i.e. \propto
  s({ trig = "pt", snippetType = "autosnippet" }, {
    t("\\propto "),
  }, { condition = cond.in_mathzone }),
  -- IFF, i.e. \iff
  s({ trig = "<>", snippetType = "autosnippet" }, {
    t("\\iff "),
  }, { condition = cond.in_mathzone }),
  -- IMPLIES, i.e. \implies
  s({ trig = ">>", snippetType = "autosnippet" }, {
    t("\\implies "),
  }, { condition = cond.in_mathzone }),
  -- IMPLIEDBY, i.e. \impliedby
  s({ trig = "<<", snippetType = "autosnippet" }, {
    t("\\impliedby "),
  }, { condition = cond.in_mathzone }),
  -- LONGRIGHTARROW, i.e. \longrightarrow
  s({ trig = "-->", snippetType = "autosnippet" }, {
    t("\\longrightarrow "),
  }, { condition = cond.in_mathzone }),
  -- RIGHTARROW, i.e. \rightarrow
  s({ trig = "->", snippetType = "autosnippet" }, {
    t("\\rightarrow "),
  }, { condition = cond.in_mathzone }),
  -- LEFTARROW, i.e. \leftarrow
  s({ trig = "<-", snippetType = "autosnippet" }, {
    t("\\leftarrow "),
  }, { condition = cond.in_mathzone }),
  -- LONGMAPSTO, i.e. \longmapsto
  s({ trig = "|>", snippetType = "autosnippet" }, {
    t("\\longmapsto "),
  }, { condition = cond.in_mathzone }),
  -- DOT PRODUCT, i.e. \cdot
  s({ trig = ",.", snippetType = "autosnippet" }, {
    t("\\cdot "),
  }, { condition = cond.in_mathzone }),
  -- CROSS PRODUCT, i.e. \times
  s({ trig = "xx", snippetType = "autosnippet" }, {
    t("\\times "),
  }, { condition = cond.in_mathzone }),
  -- FUNCTION (CUSTOM COMMAND)
  s(
    { trig = "applic", regTrig = true, wordTrig = false },
    fmta("\\applic{<>}{<>}{<>}{<>}", {
      i(1, "start"),
      i(2, "end"),
      i(3, "variable"),
      i(4, "function"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- IN
  s({ trig = "nn", snippetType = "autosnippet" }, {
    t("\\in "),
  }, { condition = cond.in_mathzone }),
  -- Logical not
  s({ trig = "lN", snippetType = "autosnippet" }, {
    t("\\lnot "),
  }, {
    condition = function(line_to_cursor, matched_trigger)
      return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("[^%\\]")
    end,
  }),
  -- LAND
  s({ trig = "and", snippetType = "autosnippet" }, {
    t("\\land "),
  }, { condition = cond.in_mathzone }),
  -- LOR
  s({ trig = "or", snippetType = "autosnippet" }, {
    t("\\lor "),
  }, { condition = cond.in_mathzone }),
  -- CAP
  s({ trig = "cap", snippetType = "autosnippet" }, {
    t("\\cap "),
  }, { condition = cond.in_mathzone }),
  -- CUP
  s({ trig = "cup", snippetType = "autosnippet" }, {
    t("\\cup "),
  }, { condition = cond.in_mathzone }),
  -- Ker
  s({ trig = "[kK]er", regTrig = true, snippetType = "autosnippet" }, {
    t("\\ker "),
  }, { condition = cond.in_mathzone }),
  -- IDENTITY FUNCTION
  s({ trig = "[iI]d", regTrig = true, snippetType = "autosnippet" }, t("\\id "), { condition = cond.in_mathzone }),
  -- FUNCTION IMAGE
  s({ trig = "[iI]mg", regTrig = true, snippetType = "autosnippet" }, {
    t("\\img "),
  }, { condition = cond.in_mathzone }),
  -- RANK
  s({ trig = "rg", regTrig = true, snippetType = "autosnippet" }, {
    t("\\rg "),
  }, { condition = cond.in_mathzone }),
  -- TRACE
  s({ trig = "tr", regTrig = true, snippetType = "autosnippet" }, {
    t("\\tr "),
  }, { condition = cond.in_mathzone }),
  -- VECT
  s(
    { trig = "[vV]ect", regTrig = true, snippetType = "autosnippet" },
    fmta("\\Vect\\left\\{<>\\right\\}", {
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DIM
  s({ trig = "[dD]im", regTrig = true, snippetType = "autosnippet" }, t("\\dim "), { condition = cond.in_mathzone }),
  -- DET
  s({ trig = "[dD]et", regTrig = true, snippetType = "autosnippet" }, {
    t("\\det "),
  }, { condition = cond.in_mathzone }),
  -- SCALAR PRODUCT
  s(
    { trig = "scc", regTrig = true, snippetType = "autosnippet" },
    fmta("\\scalar{<>}{<>} ", {
      i(1, "\\cdot"),
      i(2, "\\cdot"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DEG
  s({ trig = "deg", regTrig = true, snippetType = "autosnippet" }, {
    t("\\deg "),
  }, { condition = cond.in_mathzone }),
  -- UNDERBRACE
  s(
    { trig = "uu", snippetType = "autosnippet" },
    fmta("\\underbrace{<>}_{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),

  -- -- COMPLETE SETS AFTER \in
  -- s(
  -- 	{ trig = "\\in ([nzqrck])", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  -- 	fmta("\\in \\<>", {
  -- 		f(function(_, snip)
  -- 			return string.upper(snip.captures[1])
  -- 		end),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
  -- -- UPPERCASE AFTER \in
  -- s(
  -- 	{ trig = "\\in ([abcdefghijlmopstuvwxy])", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  -- 	fmta("\\in <>", {
  -- 		f(function(_, snip)
  -- 			return string.upper(snip.captures[1])
  -- 		end),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
}
