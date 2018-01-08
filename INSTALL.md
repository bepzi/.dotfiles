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

Install `git`, `openssh`, and `firefox`. If you're me, you'll need to
be able to log into your GitHub account so that you can clone this
repo with SSH.

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

Clone [this repo](https://github.com/dylanaraps/bin) by Dylan
Araps. We're interested in his `saur` script, which is a minimal
AUR-helper meant for installing an actual AUR-helper from the AUR
itself. Then do:

```
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
```

to install the GPG key of the packager for `cower`, which is a
dependency of `pacaur`, the AUR-helper that we *really* want to
use. Then do `./saur cower pacaur`. You can delete `saur` if you want.

*Note:* `cower` will eventually be superceded by `auracle`, at which
point it will not be necessary to install `cower` before installing `pacaur`. 

5. Get the X environment running

Install `xorg-server`, `xorg-xinit`, and `gnome-keyring`, for
managing Wi-Fi passwords and whatnot.

My config files are set up to use `i3`, a tiling window
manager. Install `i3-gaps`, `polybar`, `rofi`, and
`termite`. These are my window manager, status bar, program launcher,
and terminal emulator, respectively.

You'll also want `volumeicon`, `compton` and `dunst-git` as your
volume controller, compositor, and notification daemon, respectively.

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

First, let's fix those colors, and set a wallpaper. Install `feh`,
`scrot`, `neofetch`, `python-pywal-git`, `lxappearance`, and possibly
`arandr` if your monitor setup needs tweaking. With your desired
wallpaper(s) in hand, run:

```
wal -t -o ~/bin/scripts/wal-set -i pathtowallpaperhere
```

We need the `-t` flag because we're using `termite` as the terminal
emulator.

Install `paper-icon-theme-git` and `osx-arc-darker`. Use
`lxappearance` to set the GTK and Icon themes to these.

Install `fonts-meta-base`, `fonts-meta-extended-lt`,
`adobe-source-code-pro-fonts`, `adobe-source-sans-pro-fonts`, and
`adobe-source-serif-pro-fonts`.

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

Now open Emacs. The first time you run it, it'll complain about
missing packages - that's O.K. Just do `M-x package-install
use-package`, then restart Emacs. It'll download everything else it
needs. If you don't use
[Org-agenda](http://orgmode.org/manual/Agenda-Views.html) (and you
totally should, it's great!), you'll want to comment out the last line
in the `i3` config file, which launches Emacs at startup and opens my
agenda.org file.

Now for some essential programs.

Install: `vlc`, `qt4`, `audacity`, `gimp`, `gimp-font-rendering-fix`,
`krita`, `pulseaudio`, `pulseaudio-alsa`, `polkit-gnome`, and
`keepassxc`.

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
 
Go to **Add-ons**. In the **Appearance** tab, enable the "Compact
Light" theme.
 
Configure KeepassXC to connect to PassIFox.

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

### Dependencies

This is a list of all the packages I install on my system by default,
and what they're for.

#### Required

The system is pretty much unusable without these, or the dotfiles
behave strangely without them.

 - `networkmanager`, `network-manager-applet` -- Manages Wi-Fi and
   Ethernet connections. The latter provides `nm-applet`, which
   appears in my bar.
 - `git`, `openssh` -- For working with git repositories
 - `pulseaudio`, `pulseaudio-alsa` -- For being able to hear stuff
 - `i3-gaps` -- Fork of the [i3](https://i3wm.org/) window manager. I
   don't actually use gaps, but you can if you like.
 - `polybar` -- Fast, configurable status bar that I use to replace
   `i3bar`.
 - `rofi-git` -- Program launcher
 - `termite` -- Terminal emulator
 - `gvfs`, `gvfs-mtp`, `gamin`, `inotify-tools` -- Lets file managers
   do neat stuff like make Recycle Bins, and watch files without
   polling for changes
 - `compton` -- Compositor, required for things like shadows,
   transparency, transitions when changing windows, etc.

#### Recommended

You probably also want these installed, too.

 - `emacs` -- Extensible, customizable, frustrating ~~operating
   system~~ text editor
 - `pcmanfm-gtk3` -- Lightweight file manager
 - `feh` -- Background-setter, optional dependency of `wal`
 - `wal-git` -- Generates colorschemes from images (the `wal-set`
   script reloads `polybar` and `dunst` to use the new colors)
 - `neofetch` -- Displays system information in your terminal
 - `scrot` -- Takes screenshots
 - `lxappearance` -- Tool for setting GTK/Icon themes
 - `arandr` -- Tool for making shell commands that fix your monitor
   setup
 - `volumeicon` -- Provides an icon to control the volume. Shows up in
   the bar next to the NetworkManager applet.
 - `dunst-git` -- Notification daemon. Provides notifications when
   stuff happens.
 - `firefox` -- Web browser that supports lots of useful
   extensions. My dotfiles come with custom CSS that makes it match
   the colorscheme output by `wal`, although you have to enable the
   "Compact Light" theme (as detailed above).

#### Optional

Completely personal preference. My dotfiles may contain references to
these programs, but they should work without them installed.

 - `gimp`, `gimp-font-rendering-fix` -- GNU Image Manipulation
   Program. Excellent alternative to Photoshop.
 - `krita` -- Digital painting program
 - `vlc`, `qt4` -- Excellent multimedia player. `qt4` is needed for
   the GUI.
 - `keepassxc` -- Secure password manager that integrates nicely with
   Firefox
 - `paper-icon-theme-git`, `osx-arc-darker` -- Nice, flat GTK and icon
   theme
 - `steam`, `steam-native-runtime`, `steam-fonts` -- Steam is a
   digital distribution platform for PC games
 - `libreoffice-fresh` -- Excellent alternative to Microsoft Office
   suite
 - `rustup` -- Manages Rust toolchains
 - `exa-git` -- Fast, secure, and cool-looking alternative to `ls`
 - `contrail` -- Program I wrote to serve as a shell prompter
