#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y apt-transport-https bitwise curl exuberant-ctags gcc gdb g++ git gpg lf neovim nodejs openssl python3 ssh tar tmux valgrind wget zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
cp raw.zshrc ~/.zshrc

chsh /bin/zsh

# Setup VSCode Keyring
#wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
#sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
#sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
#rm -f packages.microsoft.gpg

# Install VSCode
#sudo apt update
#sudo apt install -y code

# Setup Vim Plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install my configuration
cp raw.vimrc ~/.vimrc

# Install vim plugins
vim +PlugInstall +qall

# Setup Neovim init.vim
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

# Pull down my colors
wget https://raw.githubusercontent.com/reelbeelveel/miamineon/master/miamineon.vim
wget https://raw.githubusercontent.com/reelbeelveel/miamineon/master/miamineon-airline.vim

mkdir -p ~/.vim/colors && mv miamineon.vim ~/.vim/colors/miamineon.vim
mkdir -p ~/.vim/plugged/vim-airline-themes/autoload/airline/themes/ && cp miamineon-airline.vim ~/.vim/plugged/vim-airline-themes/autoload/airline/themes/miamineon.vim
mv miamineon-airline.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/miamineon.vim

# stdman setup
git clone https://github.com/jeaye/stdman.git
cd stdman
./configure
sudo make install
cd ..
rm -rf stdman
sudo mandb
