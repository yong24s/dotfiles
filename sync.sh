#!/bin/bash

# Push dotfiles to git folder

cp -r ~/.config/i3              .config/
cp -r ~/.config/polybar         .config/
cp -r ~/.config/rofi            .config/
cp -r ~/.config/.Xresources.d   .config/

cp -r ~/.config/ranger          .config/
cp -r ~/.config/nvim            .config/

cp ~/.config/cmus/rc            .config/cmus/
cp ~/.config/mimeapps.list      .config/



cp -r ~/.screenlayout           .
cp ~/.zshrc                     .
cp ~/.Xresources                .

