#!/bin/bash
# Installs dotfiles to home directory
# @author Chris DeLuca (bronzehedwick)

# Add dotfiles
OS="$(uname)"
TARGET="$HOME"
DIR="$(dirname "$0")"
FILES="$DIR/.*"

find "$DIR" -type f -name "\.*" | while read -r file;
do
  # Don't link .gitignore
  if [ "$file" == "$DIR/.gitignore" ]; then
    continue
  fi

  if [ ! -f "$TARGET/$(basename "$file")" ]; then
    # Link the files
    ln -s "$file $TARGET/$(basename "$file")"
  fi
done

# If on macOS, add a .profile file instead of bashrc
if [ "$OS" == 'Darwin' ]; then
  if [ ! -f "$TARGET/.profile" ]; then
    unlink "$TARGET/.bashrc"
    ln -s "$DIR/.bashrc" "$TARGET/.profile"
  fi
fi

# Add oh my fish config
if [ -d "$TARGET/local/share/omf" ]; then
  rm -rf "$TARGET/.config/omf"
  ln -s "$DIR/omf $TARGET/.config/omf"
fi

# Install VimPlug
if [[ ! -d $TARGET/.config/nvim/autoload ]]; then
  curl -fLo "$TARGET/.config/nvim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Add NeoVim config
if [[ ! -f $TARGET/.config/nvim/init.vim ]]; then
  ln -s "$DIR/nvim/init.vim $TARGET/.config/nvim/init.vim"

  # Install NeoVim plugins
  nvim +PlugInstall +qa
fi

# Add NeoVim-at config
if [[ ! -f $TARGET/.config/nvim/ginit.vim ]]; then
  ln -s "$DIR/nvim/ginit.vim $TARGET/.config/nvim/ginit.vim"
fi

# Add emacs config
mkdir -p "$TARGET/.emacs.d"
if [ ! -f "$TARGET/.emacs.d/init.el" ]; then
  # Get evil leader plugin
  if [ ! -d "$TARGET/.emacs.d/evil-leader" ]; then
    git clone https://github.com/cofi/evil-leader.git "$TARGET/.emacs.d/evil-leader"
  fi

  # Get evil org mode plugin
  if [ ! -d "$TARGET/.emacs.d/evil-org-mode" ]; then
    git clone git://github.com/edwtjo/evil-org-mode.git "$TARGET/.emacs.d/evil-org-mode"
  fi

  # Link the config file
  ln -s "$DIR/emacs/init.el" "$TARGET/.emacs.d/init.el"
fi
