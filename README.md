# NixOS configuration files

## TODO

- Low battery warning
- Fix Librewolf theme
- Hibernation
- Power menu
- Bind brightness and volume keyboard keys
- Clean tofi fixed px sizes

## Memo

- After pushing to the nix-secrets private repo:
  ```bash
  nix flake lock --update-input nix-secrets
  ```
- To use tofi as an input
  ```bash
  echo "" | tofi --require-match=false \
    --height=80 --num-results=0  --prompt-padding=35 \
    --placeholder-text="Chapter name" --prompt-text="?"
  ```

## Thanks

- [anotherhadi/nixy](https://github.com/anotherhadi/nixy)
- [JosiahABrown/nixdots](https://github.com/JosiahABrown/nixdots)
- [EmergentMind/nix-config](https://github.com/EmergentMind/nix-config)
