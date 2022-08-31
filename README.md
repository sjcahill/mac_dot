# Dotfiles for Macbook

Some basic dotfiles for MacOS.

Zsh, neovim and kitty terminal.

If the nesting structure of the folders looks a little weird this is because I have configured this to work with
GNU `stow`.  

You can install `stow` using homebrew and it will place symlinks to the config files in a target directory
directory regardless of where these dotfiles live on your machine.

So, assuming you have installed `stow` and cloned this repo. `cd` into this repo directory on your local machine
and run `stow -t ~ *`.

This tells stow to create the appropriate symlinks in your home directory for all folders
in the repo.

If you only need `zsh` you can instead do `stow -t ~ zsh` to create the one symlink.