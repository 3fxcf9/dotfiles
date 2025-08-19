return {
  {
    "stevearc/conform.nvim",
    config = function()
      local slow_format_filetypes = {
        latex = true,
        tex = true,
        python = true,
      }

      -- Create commands for disabling/enabling autoformat
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! disables formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      require("conform").setup({
        notify_on_error = true,

        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,

        format_after_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = true }
        end,

        formatters_by_ft = {
          v = { "vfmt" },
          html = { "prettierd" },
          css = { "prettierd" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          python = { "black", "isort" },
          lua = { "stylua" },
          nix = { "alejandra" },
          markdown = { "prettierd" },
          yaml = { "prettierd" },
          bash = { "shellcheck", "shellharden", "shfmt" },
          json = { "jq" },
          rust = { "rustfmt" },
          tex = { "latexindent" },
          ocaml = { "ocamlformat" },
          ["_"] = { "trim_whitespace" },
        },
      })
    end,
  },
}

