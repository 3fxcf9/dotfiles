{pkgs, ...}: {
  home.packages = with pkgs; [alejandra nodePackages.prettier stylua black isort];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      conform-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        local conform = require("conform")

        conform.setup({
          formatters_by_ft = {
            nix = { "alejandra" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            liquid = { "prettier" },
            lua = { "stylua" },
            python = { "isort", "black" },
            tex = { "latexindent" },
          },
          format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 5000,
          })
        end, { desc = "Format file or range (in visual mode)" })
      '';
  };
}
