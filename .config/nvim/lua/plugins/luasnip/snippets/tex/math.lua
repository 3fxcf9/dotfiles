---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local cond = require("_utils.mathzone_detection")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local get_visual = require("_utils.get_visual").get_visual
------------------------------------------------------------------------------

return {
  -- SUPERSCRIPT
  s(
    { trig = "([%w%)%]%}])^", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SUBSCRIPT
  s(
    { trig = "([%w%)%]%}%'])_", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  s(
    { trig = "([%w%)%]%}%']);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
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
    { trig = "([%w%)%]%}])'([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SUBSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a subscript.
  s(
    { trig = "([%w%)%]%}%'])%.([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  s(
    { trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- ZERO SUBSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("0"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- MINUS ONE SUPERSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("-1"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- CROSS SUPERSCRIPT
  s(
    { trig = "([%a%)%]%}])XX", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("^{\\times}"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- TRANSPOSITION
  s(
    { trig = "([%a%)%]%}])TT", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("\\transp"),
    }),
    { condition = cond.in_mathzone }
  ),
  -- STAR AFTER SET
  s(
    { trig = "(\\[NZQRK])%*", regTrig = true, wordTrig = true, snippetType = "autosnippet" },
    fmta("<>^{*}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- STAR AFTER SET (with plus)
  s(
    { trig = "(\\[NZQRK]%_%{%+%})%*", regTrig = true, wordTrig = true, snippetType = "autosnippet" },
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
  -- s(
  -- 	{ trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
  -- 	fmta("<>^{<>}", {
  -- 		f(function(_, snip)
  -- 			return snip.captures[1]
  -- 		end),
  -- 		t("+"),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
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
  -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
  -- s(
  -- 	{ trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
  -- 	fmta("<>^{<>}", {
  -- 		f(function(_, snip)
  -- 			return snip.captures[1]
  -- 		end),
  -- 		t("*"),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
  -- VECTOR, i.e. \vec
  s(
    { trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vec{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
  s(
    { trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\unitvector_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- UNIT VECTOR WITH HAT, i.e. \uvec{}
  -- s(
  -- 	{ trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  -- 	fmta("<>\\uvec{<>}", {
  -- 		f(function(_, snip)
  -- 			return snip.captures[1]
  -- 		end),
  -- 		d(1, get_visual),
  -- 	}),
  -- 	{ condition = cond.in_mathzone }
  -- ),
  -- MATRIX, i.e. \mtx
  s(
    { trig = "([^%a])mt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\mtx{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- FRACTION
  s(
    { trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\frac{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- ANGLE
  s(
    { trig = "([^%a])gg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\ang{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- ABSOLUTE VALUE, i.e \abs
  s(
    { trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\abs{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- INTERVALS
  s(
    { trig = "([^%a])oo", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\oo{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  s(
    { trig = "([^%a])of", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\oc{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  s(
    { trig = "([^%a])co", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\co{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  s(
    { trig = "([^%a])cc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\cc{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- TILDE
  s(
    { trig = "([^%a])tll", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\tilde{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SQUARE ROOT
  s(
    { trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sqrt{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- BINOMIAL SYMBOL
  s(
    { trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\binom{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- LOGARITHM WITH BASE SUBSCRIPT
  s(
    { trig = "([^%a%\\])lg", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\log_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DERIVATIVE with denominator only
  s(
    { trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DERIVATIVE with numerator and denominator
  s(
    { trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dvN{<>}{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with denominator only
  s(
    { trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator and denominator
  s(
    { trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdvN{<>}{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SUM with lower limit
  s(
    { trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sum_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- SUM with upper and lower limit
  s(
    { trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sum_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PRODUCT with lower limit
  s(
    { trig = "([^%a])pD", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\prod_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- PRODUCT with upper and lower limit
  s(
    { trig = "([^%a])pdd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\prod_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- INTEGRAL with only lower limit
  s(
    { trig = "([^%a])intT", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- INTEGRAL with upper and lower limit
  s(
    { trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = cond.in_mathzone }
  ),
  -- INTEGRAL from positive to negative infinity
  s(
    { trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int_{\\infty}^{\\infty}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = cond.in_mathzone }
  ),
  -- INFTY
  s({ trig = "inff", snippetType = "autosnippet" }, {
    t("\\infty"),
  }),
  -- BOXED command
  s(
    { trig = "([^%a])bb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\boxed{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = cond.in_mathzone }
  ),
  --
  -- BEGIN STATIC SNIPPETS
  --

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
  -- GEQ
  s({ trig = "geq", snippetType = "autosnippet" }, {
    t("\\geq "),
  }, { condition = cond.in_mathzone }),
  -- LEQ
  s({ trig = "leq", snippetType = "autosnippet" }, {
    t("\\leq "),
  }, { condition = cond.in_mathzone }),
  -- IN
  s({ trig = "nn", snippetType = "autosnippet" }, {
    t("\\in "),
  }, { condition = cond.in_mathzone }),
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
    t("\\Ker "),
  }, { condition = cond.in_mathzone }),
  -- IDENTITY FUNCTION
  s(
    { trig = "[iI]d", regTrig = true, snippetType = "autosnippet" },
    fmta("\\Id_{<>}", {
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- FUNCTION IMAGE
  s({ trig = "[iI]mg", regTrig = true, snippetType = "autosnippet" }, {
    t("\\Img "),
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
  s(
    { trig = "[dD]im", regTrig = true, snippetType = "autosnippet" },
    fmta("\\dim_{<>} ", {
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
  -- DET
  s(
    { trig = "[dD]et", regTrig = true, snippetType = "autosnippet" },
    fmta("\\det_{<>} ", {
      i(1),
    }),
    { condition = cond.in_mathzone }
  ),
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
