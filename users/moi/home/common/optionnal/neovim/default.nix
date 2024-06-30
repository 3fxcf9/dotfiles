{
  pkgs,
  lib,
  ...
}: let
  fromGitHub = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };
in {
  imports = [
    # First will be last in generated init.lua
    ./plugins/nvim-cmp.nix
    ./plugins/indent-blankline.nix
    ./plugins/nvim-tree-lua.nix
    ./plugins/lualine.nix
    ./plugins/todo-comments.nix
    ./plugins/formatting.nix
    ./plugins/lsp.nix
    ./plugins/alpha.nix
    ./plugins/colorscheme.nix
    ./options.nix
    ./keymaps.nix
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      dressing-nvim
    ];
  };
}
