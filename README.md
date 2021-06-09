# dotfiles

![My desktop](screenshots/rice_01_13_2019.png)

My personal configuration files, powered by [Dotbot](https://github.com/anishathalye/dotbot). Emacs configuration files can be found [here](https://github.com/bepzi/.emacs.d).

## Usage

```bash
git clone --recurse-submodules https://github.com/bepzi/.dotfiles.git && \
cd ~/.dotfiles && \
git submodule update --init --recursive && \
./install
```

`install` can be run multiple times in a row without fear of breaking anything. Any conflicts must be resolved manually, but Dotbot will tell you what the symlinks are conflicting with.

See the Dotbot documentation for more options.
