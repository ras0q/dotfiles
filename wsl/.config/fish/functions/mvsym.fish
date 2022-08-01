function mvsym
      set -x DOTFILES_DIR ~/ghq/github.com/Ras96/dotfiles
      set -x FILE $argv[1]
      mv $HOME/$FILE $DOTFILES_DIR/$FILE && \
      ln -s $DOTFILES_DIR/$FILE $HOME/$FILE && \
      echo "ln -s \$DOTFILES_DIR/$FILE \$HOME/$FILE" >> $DOTFILES_DIR/scripts/symboliclinks.sh
end
