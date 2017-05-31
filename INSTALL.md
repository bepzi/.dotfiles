# Installation

This is a guide on how to get a system that's 100% compatible with the
dotfiles in this repository. Mostly for my own reference, but this
should be everything you need for a decent, working Arch Linux
installation. There's a big list of dependencies (required,
recommended, and optional) at the bottom of this guide.

1. Install Arch Linux. If you know how you want your system to be
   set up, disregard these instructions (until about step 4).

See
[here](https://wiki.archlinux.org/index.php/Installation_guide). 

Proceed until
section
[2.2](https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages),
and instead of running `pacstrap /mnt base`, do `pacstrap /mnt base
base-devel emacs`. Emacs is optional, of course (Who am I
kidding? Of course it isn't).

When you are `chroot`ed into the system and have gotten to the section
on
[Network Configuration](https://wiki.archlinux.org/index.php/Installation_guide#Network_configuration),
install `networkmanager` and `network-manager-applet`. Then do
`systemctl enable NetworkManager.service`.

Then install `intel-ucode` (if on an Intel-based system), `grub`,
`efibootmgr`, `os-prober`, and `ntfs-3g` (if your system uses
NTFS-formatted
drives). [Install GRUB2](https://wiki.archlinux.org/index.php/GRUB#UEFI_systems).

Your system should now be bootable and should automatically connect to
the Internet.

2. Create your user(s) in group `wheel`

Allow your user to use `sudo` by doing `EDITOR="emacs -nw" visudo` to
allow members of group `wheel` to execute any command with
`sudo`. Don't forget to set any passwords with `passwd usernamehere`.

Log out of `root` and log back in as your new user.

3. Some minor configuration

Install `git` and `openssh`.

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

5. Get the X environment running

Install `xorg-server`, `xorg-xinit`, `xlogin-git`, and
`xorg-xbacklight` (optional). Also install: `gnome-keyring`, for
managing Wi-Fi passwords and whatnot.

I use `xlogin` to automatically source my `~/.xinitrc` and log in,
but if that's not something you want, don't install `xlogin` and
install the display manager of your choice. *Otherwise*, do `sudo
systemctl enable xlogin@yourusernamegoeshere.service`. Just make sure
whatever you use sources `~/.xinitrc`, failing that, `~/.xprofile`.

My config files are set up to use `i3`, a tiling window
manager. Install `i3-gaps`, `polybar`, `rofi-git`, and
`termite`. These are my window manager, status bar, program launcher,
and terminal emulator, respectively.

You'll also want `volumeicon`, `compton` and `dunst-git` as your
volume controller, compositor, and notification daemon, respectively.

6. Install the dotfiles

```bash
git clone https://github.com/ben01189998819991197253/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles && \
git submodule update --init --recursive && \
./install
```

When you run `./install`, it's certain that it'll complain about files
already existing (like `~/.bash_profile`, `~/.bashrc`, etc.) Delete
all the conflicts, and run `./install` again.

**Important note:** I type in
the [Dvorak](https://en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard)
keyboard layout. You probably do not. Comment out this line near the
bottom of `~/.xprofile`:

```
setxkbmap dvorak
```

And in `~/.xinitrc`:

```
setxkbmap dvorak &
```

(I do it twice because some systems only source one or the other.)

Now when you restart, you should have a working (if bland) i3 session,
bar, program launcher, notification daemon, and some other goodies.

7. Install some neat programs

First, let's fix those colors, and set a wallpaper. Install `feh`,
`scrot`, `neofetch`, `wal-git`, `lxappearance`, and possibly `arandr`
if your monitor setup needs tweaking. With your desired wallpaper(s)
in hand, run:

```
wal -t -o ~/bin/scripts/wal-set -i pathtowallpaperhere
```

We need the `-t` flag because we're using termite as the terminal
emulator.

Now open Emacs. The first time you run it, it'll complain about
missing packages - that's O.K. Just do `M-x install-package
use-package`, then restart Emacs. It'll download everything else it
needs. If you don't
use [Org-agenda](http://orgmode.org/manual/Agenda-Views.html) (and you
totally should, it's great!), you'll want to comment out the last line
in the `i3` config file, which launches Emacs at startup and opens my
agenda.org file.

Now for some essential programs.

Install: `firefox`, `vlc`, `qt4`, `audacity`, `gimp`,
`gimp-font-rendering-fix`, `krita`, `pulseaudio`, `pulseaudio-alsa`,
`keepassxc`.

If you do not use `keepassxc` (it's a password manager), don't install
the PassIFox Firefox extension.

Open Firefox. Go to Preferences, and set the default search engine to
DuckDuckGo. Disable Search suggestions. While you're at it, delete all
the other search engines. In the Privacy section, click "manage your
Do Not Track settings", and always apply Do Not Track. "Use custom
settings for history". Tick "Always use private browsing mode", and
set "Accept third-party cookies" to "Never". If it's enabled, disable
the offer to save passwords in the Security section.

Go to Add-ons. Install:

 - [uBlock Origin](https://github.com/gorhill/uBlock)
 - [HTTPS Everywhere](https://www.eff.org/https-everywhere)
 - [NoScript](https://noscript.net/)
 - [Reddit Enhancement Suite](https://redditenhancementsuite.com/)
 - [PassIFox](https://github.com/pfn/passifox)
