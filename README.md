# My Arch Linux Configuration

<img src="./assets/screenshot1.png" alt="screenshot"/>

## Installation

In the live system

```bash
loadkeys fr
iwctl
```

then

```iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect SSID
```

Exit iwctl and run `archinstall`. Install the **bspwm** profile with the **lightdm** greeter.

## Remove the greeter

```zsh
sudo systemctl disable lightdm
sudo pacman -Runs lightdm-gtk-greeter
```

## Config Files

```zsh
cd
sudo pacman -S git stow
git clone https://github.com/3fxcf9/dotfiles
stow dotfiles
```

Among others, the `.xinitrc` file will get linked in the home.

## Packages

Install paru
```zsh
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

Bspwm

```zsh
sudo pacman -S bspwm sxhkd xorg-xinput xorg-xsetroot polybar maim xclip xdotool
mkdir ~/Screenshots
```

Fix polybar backlight

```zsh
sudo chown $USER /sys/class/backlight/amdgpu_bl1/brightness
```

Fonts

```zsh
sudo pacman -S otf-monaspace-nerd
```

Applications

```zsh
sudo pacman -S kitty firefox btop neovim signal-desktop yazi zathura zathura-pdf-mupdf
```

Utils

```zsh
sudo pacman -S pavucontrol man-db unzip bat fd rg fastfetch cpufetch zoxide udisks2 jq
```

Zsh

```zsh
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting eza fzf
paru -S pursarship    # Shell
chsh -s $(which zsh)

############## Reboot if needed ##############
```

Kanata

```zsh
paru kanata

# Permissions
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' > /etc/udev/rules.d/99-input.rules
sudo udevadm control --reload && udevadm trigger --verbose --sysname-match=uniput
sudo modprobe uinput

############## Reboot if needed ##############

systemctl --user enable kanata.service
systemctl --user start kanata.service

# Re-run bspwm config file
```

Git and github

```
sudo pacman -S github-cli git-delta
gh auth login

# Generate signing key
gpg --gen-key
gpg --list-secret-keys --keyid-format LONG
```

## Dev

```zsh
paru -S vlang nodejs npm tree-sitter tree-sitter-cli
```

OCaml

```zsh
sudo pacman -S opam
opam init -y
opam install odoc utop  # ocaml-lsp and ocamlformat are managed by Mason
```

3D printing

```zsh
sudo pacman -S prusa-slicer
```

Syncthing

```zsh
sudo pacman -S syncthing
sudo systemctl enable syncthing@moi.service
sudo systemctl start syncthing@moi.service
# SET USERNAME AND PASSWORD: localhost:8384
```

School

```zsh
sudo pacman -S inkscape python3 python-pip python-xlib rofi
sudo pacman -S texlive-basic texlive-latex texlive-latexrecommended texlive-fontsrecommended texlive-mathscience texlive-latexextra pdf2svg
# TODO: Add course_manager setup
```


### Power management

```zsh
sudo pacman -S tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
```

Customize in `/etc/tlp.conf`. Change `systemctl suspend-then-hibernate` delay in `/etc/systemd/sleep.conf`.

- Suspend hook:
  ```zsh
  sudo mkdir -p /usr/lib/systemd/system-sleep
  sudo nvim /usr/lib/systemd/system-sleep/10-s2idle-tune
  ```
  Content:
  ```bash
  #!/bin/bash
  case "$1" in
   pre)
     # Before suspend
     nmcli radio wifi off 2>/dev/null || true
     systemctl stop syncthing.service 2>/dev/null || true
     ;;
   post)
     # After resume
     nmcli radio wifi on 2>/dev/null || true
     systemctl start syncthing.service 2>/dev/null || true
     ;;
  esac
  ```
  ```zsh
  sudo chmod +x /usr/lib/systemd/system-sleep/10-s2idle-tune
  ```

- Tune power button behavior in `/etc/systemd/logind.conf` (run `sudo systemctl restart systemd-logind` after edit)

### Hibernation

- ```zsh
  sudo btrfs filesystem mkswapfile --size 16G /swapfile
  swapon /swapfile
  ```
- Edit `/etc/systemd/system.conf.d/hibernate.conf` with
  ```
  [Sleep]
  HibernateMode=platform
  HibernateDelaySec=0
  ```
- Execute this command
  ```zsh
  root_uuid=$(sudo findmnt -no UUID /)
  offset=$(sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-1)}')
  echo "systemd.resume=UUID=$root_uuid systemd.resume_offset=$offset"
  ```
  and add the result to the options line of `/boot/loader/entries/2025-08-18_11-26-04_linux.conf`.
- Add the `resume` hook to `/etc/mkinitcpio.conf`.
- Run
  ```zsh
  sudo mkinitcpio -P
  sudo bootctl update
  ```
- Reboot


### Course manager

```zsh
# Figure manager
sudo pacman -S inotify-tools scour rofi inkscape
```
Add built binaries to `~/.local/bin`.


