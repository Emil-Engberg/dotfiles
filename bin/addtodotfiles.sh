#!/bin/bash
cp -r $1 ~/github/dotfiles/
rm -rf $1
ln -sf ~/github/dotfiles/$1 $1
tac ~/github/dotfiles/install.sh | tail -n +2 | tac > ~/github/dotfiles/installtemp.sh
echo "ln -sf ~/github/dotfiles/$1 $PWD/" >> ~/github/dotfiles/installtemp.sh
echo "EOF" >> ~/github/dotfiles/installtemp.sh
rm -rf ~/github/dotfiles/install.sh
mv ~/github/dotfiles/installtemp.sh ~/github/dotfiles/install.sh
