---@diagnostic disable: undefined-global
------------------------------------------------------------------------------
local cond = require("_utils.contextual_conditions")
------------------------------------------------------------------------------

return {
  s({ trig = ",a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",b", snippetType = "autosnippet" }, {
    t("\\beta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",G", snippetType = "autosnippet" }, {
    t("\\Gamma"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",d", snippetType = "autosnippet" }, {
    t("\\delta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",D", snippetType = "autosnippet" }, {
    t("\\Delta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",e", snippetType = "autosnippet" }, {
    t("\\epsilon"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",ve", snippetType = "autosnippet" }, {
    t("\\varepsilon"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",z", snippetType = "autosnippet" }, {
    t("\\zeta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",h", snippetType = "autosnippet" }, {
    t("\\eta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",o", snippetType = "autosnippet" }, {
    t("\\theta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",vo", snippetType = "autosnippet" }, {
    t("\\vartheta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",O", snippetType = "autosnippet" }, {
    t("\\Theta"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",k", snippetType = "autosnippet" }, {
    t("\\kappa"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",L", snippetType = "autosnippet" }, {
    t("\\Lambda"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",m", snippetType = "autosnippet" }, {
    t("\\mu"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",n", snippetType = "autosnippet" }, {
    t("\\nu"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",x", snippetType = "autosnippet" }, {
    t("\\xi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",X", snippetType = "autosnippet" }, {
    t("\\Xi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",p", snippetType = "autosnippet" }, {
    t("\\pi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",P", snippetType = "autosnippet" }, {
    t("\\Pi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",r", snippetType = "autosnippet" }, {
    t("\\rho"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",s", snippetType = "autosnippet" }, {
    t("\\sigma"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",S", snippetType = "autosnippet" }, {
    t("\\Sigma"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",t", snippetType = "autosnippet" }, {
    t("\\tau"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",f", snippetType = "autosnippet" }, {
    t("\\phi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",vf", snippetType = "autosnippet" }, {
    t("\\varphi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",F", snippetType = "autosnippet" }, {
    t("\\Phi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",c", snippetType = "autosnippet" }, {
    t("\\chi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",i", snippetType = "autosnippet" }, {
    t("\\psi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",I", snippetType = "autosnippet" }, {
    t("\\Psi"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",w", snippetType = "autosnippet" }, {
    t("\\omega"),
  }, { condition = cond.in_mathzone }),
  s({ trig = ",W", snippetType = "autosnippet" }, {
    t("\\Omega"),
  }, { condition = cond.in_mathzone }),
}
