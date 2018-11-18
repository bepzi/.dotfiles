# Installation

This is a guide on how to get a system that's 100% compatible with the
dotfiles in this repository. Mostly for my own reference, but this
should be everything you need for a decent, working Arch Linux
installation. There's a big list of dependencies (required,
recommended, and optional) at the bottom of this guide.

1. Install Arch Linux. If you know how you want your system to be set
   up, disregard these instructions (until about step 4).

See [here](https://wiki.archlinux.org/index.php/Installation_guide).

Proceed until section
[2.2](https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages),
and instead of running `pacstrap /mnt base`, do `pacstrap /mnt base
base-devel emacs`. Emacs is optional, of course (Who am I kidding? Of
course it isn't).

When you are `chroot`ed into the system and have gotten to the section
on [Network
Configuration](https://wiki.archlinux.org/index.php/Installation_guide#Network_configuration),
install `networkmanager` and `network-manager-applet`. Then do
`systemctl enable NetworkManager.service`.

Then install `intel-ucode` (if on an Intel-based system), `grub`,
`efibootmgr`, `os-prober`, and `ntfs-3g` (if your system uses
NTFS-formatted drives). [Install
GRUB2](https://wiki.archlinux.org/index.php/GRUB#UEFI_systems).

Also install `linux-lts` and `linux-lts-headers` so that you have a
fallback kernel you can use in case a kernel update prevents you from
booting. You'll need to configure GRUB to automatically use the normal
`linux` kernel later, though.

Your system should now be bootable and should automatically connect to
the Internet.

2. Create your user(s) in group `wheel`

Allow your user to use `sudo` by doing `EDITOR="emacs -nw" visudo` to
allow members of group `wheel` to execute any command with
`sudo`. Don't forget to set any passwords with `passwd usernamehere`.

Log out of `root` and log back in as your new user.

3. Some minor configuration

Install `git`, `openssh`, `bash-completion`, and `firefox`. If you're
me, you'll need to be able to log into your GitHub account so that you
can clone this repo with SSH.

To get `git` up and running properly, execute in order:

 - `git config --global user.name yournamegoeshere`
 - `git config --global user.email youremailgoeshere`
 - `ssh-keygen -t rsa -b 4096 -C "youremailgoeshere"`
 - `eval "$(ssh-agent -s)"`
 - `ssh-add ~/.ssh/id_rsa`

You can now add `~/.ssh/id_rsa.pub` to whatever applications you need.

4. Configure `pacman` and access the AUR

Logged in as your new user, do `sudo emacs -nw /etc/pacman.conf`.

Find this section (under the `[options]` header):

```
# Misc options
#UseSyslog
#Color
#TotalDownload
CheckSpace
#VerbosePkgLists
```

And uncomment `Color`.

At the bottom, where the repositories are defined, uncomment
`[multilib]` to enable 32-bit packages (needed for Steam and for some
other programs). Then, at the very bottom of the file, add:

```
[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
```

Do `sudo pacman -Syu` to update your system and get package lists from
the `multilib` and `archlinuxfr` repositories.

Then install `reflector`, and place the following snippet of code in a
file named `mirrorupgrade.hook` at `/etc/pacman.d/hooks/`:

```
[Trigger]
Operation = Upgrade
Type = Package
Target = pacman-mirrorlist

[Action]
Description = Updating pacman-mirrorlist with reflector and removing pacnew...
When = PostTransaction
Depends = reflector
Exec = /bin/sh -c "reflector --country 'United States' --latest 100 --age 24 --sort rate --save /etc/pacman.d/mirrorlist; rm -f /etc/pacman.d/mirrorlist.pacnew"
```

This will automatically retrieve the top 100 fastest mirrors within
the United States and replace your pacman mirrorlist with that list,
sorted by speed. See: https://wiki.archlinux.org/index.php/Reflector#Pacman_Hook

Clone [this repo](https://github.com/dylanaraps/bin) by Dylan
Araps. We're interested in his `saur` script, which is a minimal
AUR-helper meant for installing an actual AUR-helper from the AUR
itself. Use it to install `yay`, which is an AUR helper. I used to
recommend `pacaur`, but it has been deprecated and is no longer
maintained. You can then delete your local copy of the repository.

5. Get the X environment running

Install `xorg-server`, `xorg-xinit`, and `gnome-keyring`, for
managing Wi-Fi passwords and whatnot.

My config files are set up to use `i3`, a tiling window
manager. Install `i3-gaps`, `polybar`, `rofi`, and
`termite`. These are my window manager, status bar, program launcher,
and terminal emulator, respectively.

You'll also want `volumeicon`, `compton` and `dunst-git` as your
volume controller, compositor, and notification daemon, respectively.

If you use a laptop, install `cbatticon`.

Install `numlockx` to have Numlock automatically enabled on startup.

6. Install the dotfiles

```bash
git clone https://github.com/ben01189998819991197253/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles && \
git submodule update --init --recursive && \
./install
```

When you run `./install`, it's certain that it'll complain about files
already existing (like `~/.bash_profile`, `~/.bashrc`, etc.) Delete
all conflicts, and run `./install` again.

**Important note:** I type in the
[Dvorak](https://en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard)
keyboard layout. You probably do not. Comment out this line near the
bottom of `~/.xprofile`:

```
setxkbmap dvorak
```

Now when you restart, you should have a working (if bland) i3 session,
bar, program launcher, notification daemon, and some other goodies.

7. Install some neat programs, and CONFIGURATION

Install `archdroid-icon-theme-git` and `oomox-git`.

First, let's fix those colors, and set a wallpaper. Install `feh`,
`scrot`, `neofetch`, `python-pywal-git`, `lxappearance`, and possibly
`arandr` if your monitor setup needs tweaking. With your desired
wallpaper(s) in hand, run:

```
wal -o ~/bin/scripts/wal-set -i pathtowallpaperhere
```

Use `lxappearance` to set the GTK theme to "wal" and the icon theme to
whatever Archdroid theme suites your wallpaper.

Install `fonts-meta-base`, `fonts-meta-extended-lt`,
`ttf-material-design-icons`, `adobe-source-code-pro-fonts`,
`adobe-source-sans-pro-fonts`, and `adobe-source-serif-pro-fonts`.

Follow [this
guide](https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671). Skip
the instructions about removing Infinality packages, we never
installed them, and you don't need to create an
`/etc/fonts/local.conf`. My font configuration is already set up to
provide an Infinality-like experience. In particular, you just need to
do:

```bash
ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
ln -s /etc/fonts/conf.avail/30-infinality-aliases.conf /etc/fonts/conf.d
```

Now open Emacs. If it complains about missing packages - that's
O.K. Just do `M-x package-install use-package`, then restart
Emacs. It'll download everything else it needs.

Add the following file to `~/.config/systemd/user/emacs.service`:

```
[Unit]
Description=Emacs text editor
Documentation=info:emacs man:emacs(1) https://gnu.org/software/emacs/

[Service]
Type=simple
ExecStart=/usr/bin/emacs --fg-daemon
ExecStop=/usr/bin/emacsclient --eval "(kill-emacs)"
Environment=SSH_AUTH_SOCK=%t/keyring/ssh
Restart=on-failure

[Install]
WantedBy=default.target
```

and do `systemctl --user enable --now emacs`

Also add the following file to `~/.local/share/applications/emacs.desktop`:

```
[Desktop Entry]
Name=Emacs
GenericName=Text Editor
Comment=Edit text
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
Exec=emacsclient -c %F
Icon=emacs
Type=Application
Terminal=false
Categories=Development;TextEditor;
StartupWMClass=Emacs
Keywords=Text;Editor;
```

Now for some essential programs.

Install: `vlc`, `qt4`, `audacity`, `gimp`, `gimp-font-rendering-fix`,
`krita`, `pulseaudio`, `pulseaudio-alsa`, `pavucontrol`, `mpd`, `mpc`,
`ncmpcpp`, `polkit-gnome`, and `keepassxc`.

If you do not use `keepassxc` (it's a password manager), don't install
the PassIFox Firefox extension.

Open Firefox. Go to **Preferences**: in the **Search** tab, set the
default search engine to DuckDuckGo. Disable Search suggestions. While
you're at it, delete all the other search engines. In the **Privacy**
section, click "manage your Do Not Track settings", and always apply
Do Not Track. "Use custom settings for history". Tick "Always use
private browsing mode", and set "Accept third-party cookies" to
"Never". If it's enabled, disable the offer to save passwords in the
Security section.

Go to `about:config`. Create a new string pref named
`widget.content.gtk-theme-override` and as a value set an installed
light GTK3 theme name (e.g. `Adwaita:light`, `Breeze-Light` etc), then
restart Firefox. This fixes issues with dark GTK themes causing
unreadable input text boxes.

Go to **Add-ons**. Install:

 - [uBlock Origin](https://github.com/gorhill/uBlock): FOSS and
   lightweight ad-blocker
   * Under **Privacy**, tick "Prevent WebRTC from leaking local IP
    addresses"
   * In the **3rd-party filters** tab, under **Ads**, enable
     "Anti-Adblock Killer | Reek"
 - [HTTPS Everywhere](https://www.eff.org/https-everywhere): Force
   sites that offer HTTPS to use HTTPS instead of HTTP
   * Disable sending certificates to the Observatory
 - [NoScript](https://noscript.net/): Block JavaScript, Flash, etc by
   default
   * In the **General** tab, tick "Temporarily allow top-level sites
     by default", and select "Base 2nd level Domains
     (noscript.net)". Tick "Automatically reload affected pages when
     permissions change", and also "Reload the current tab only"
   * In the **Notifications** tab, untick "Show message about blocked
     scripts" and "Place message at the bottom". Also untick "Display
     the release notes on updates"
 - [Reddit Enhancement Suite](https://redditenhancementsuite.com/):
   Make browsing reddit.com more enjoyable
 - [PassIFox](https://github.com/pfn/passifox): Communicates with
   `keepassxc`, alternative to the built in password manager

Open GIMP. In the **Windows** tab, tick "Single-Window Mode".

Install `openvpn` and `openvpn-update-resolv-conf-git` if you use
OpenVPN. Manually edit `/etc/openvpn/update-resolv-conf` (tip: use
`sudo emacs -nw`) and replace the assignment to the `RESOLVCONF`
variable with `/usr/bin/resolvconf`. It should look like this:

```
# Bunch of comments
export PATH=$PATH:/......
RESOLVCONF=/usr/bin/resolvconf
```

Install `gvfs`, `gvfs-mtp`, `gamin`, `inotify-tools`, `xarchiver`,
`p7zip`, `unzip`, `unrar`, and `pcmanfm-gtk3`.

Install `steam-native-runtime`, and `steam-fonts` if you use Steam.

Install `redshift-gtk-git` if you use Redshift.

*Bonus:* Install a replacement for `ls`:

Install `rustup`. Then do `rustup update stable && rustup default
stable && rustup component add rust-src`. This installs the
[Rust](https://www.rust-lang.org/en-US/) compiler, source code, and
sets the default toolchain to the latest stable version.

Install `exa-git`.

Clone my
[aur-pkgbuilds](https://github.com/ben01189998819991197253/aur-pkgbuilds)
repository, and install `contrail` with `makepkg -sri`. The config
file should already be installed to `~/.config/contrail.toml`.
