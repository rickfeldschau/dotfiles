#!/bin/bash
# This script assumes running on a fresh system under bash and that you have
#   a private ssh key file called id_rsa and this script (installDotfiles.sh)
#   in $HOME or your host system Downloads directory.
# For example, the script expects the following:
#   - Windows WSL::%userprofile%\Downloads\id_rsa
#   - ChromeOS::$HOME/Downloads/id_rsa
# else it requires the ssh key files placed on the client system
#   - $HOME/id_rsa
# The filename of the private ssh key file can be changed with the variable
#   $KEY_FILENAME below.


###############################################################################
# VARIABLES
###############################################################################
DEBUG_MODE=false
KEY_FILENAME='id_rsa'
SHELL_CONFIG_FILE='.bashrc'
DOTFILES_CONTRIBUTOR=false
STARTING_IN_CLONE=true
INSTALL_FONTS=false

NVM_VERSION=0.38.0
CTAGS_VERSION=5.8
PYTHON_VERSION=3.9.6
NCURSES_VERSION=6.2

###############################################################################
# ECHO COMMANDS 
###############################################################################
if [ $DEBUG_MODE = "true" ]; then
  set -o verbose
fi


###############################################################################
# MORE VARIABLE CONFIGURATION
###############################################################################
if [ $DOTFILES_CONTRIBUTOR = "true" ]; then
  read -p "Enter your git user.name (leave blank if none): " GIT_USERNAME
  GIT_USERNAME=${GIT_USERNAME}
  read -p "Enter your git user.email (leave blank if none): " GIT_EMAIL
  GIT_EMAIL=${GIT_EMAIL}
fi

if [ -f "$HOME/$KEY_FILENAME" ]; then
  SSH_KEY_LOCATION='$HOME/$KEY_FILENAME'
elif [ $CLOUD_SHELL = "true" ]; then
  SSH_KEY_LOCATION='$HOME/$KEY_FILENAME'
elif [ ! -z $SOMMELIER_VERSION ]; then
  SSH_KEY_LOCATION='/mnt/chromeos/MyFiles/Downloads/$KEY_FILENAME'
elif grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  SSH_KEY_LOCATION="$(wslpath $(wslvar USERPROFILE))/Downloads/$KEY_FILENAME"
fi

if [ $DEBUG_MODE = "true" ]; then
  echo $CLOUD_SHELL
  echo $SOMMERLIER_VERSION
  echo $SSH_KEY_LOCATION
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# INITIAL SETUP
###############################################################################
if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  sudo apt update
  sudo apt -y upgrade
fi
mkdir $HOME/local
mkdir $HOME/git
mkdir $HOME/bin
export PATH=$HOME/bin:$PATH
echo 'PATH=$HOME/bin:$PATH' >> $HOME/$SHELL_CONFIG_FILE
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# INSTALL PREREQS 
###############################################################################
if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  sudo apt -y install build-essential cmake python3-dev libncurses5-dev git
elif [[ $CLOUD_SHELL = "true" ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
  curl https://pyenv.run | bash
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/$SHELL_CONFIG_FILE
  echo 'eval "$(pyenv init -)"' >> ~/$SHELL_CONFIG_FILE
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/$SHELL_CONFIG_FILE
  pyenv install ${PYTHON_VERSION}
  pyenv global ${PYTHON_VERSION}
fi
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# NCURSES
###############################################################################
if [[ $CLOUD_SHELL = "true" ]]; then
  wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
  tar zxf ncurses-$NCURSES_VERSION.tar.gz -C $HOME/git/
  pushd $HOME/git/ncurses-$NCURSES_VERSION
  ./configure --prefix=$HOME/usr/local CXXFLAGS="-fPIC" CFLAGS="-fPIC"
  make -j
  make install
  popd
fi


###############################################################################
# VIM
###############################################################################
# # TODO: install and configure neovim instead of vim
if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  sudo apt -y remove vim vim-runtime gvim
  sudo apt -y autoremove
  git clone https://github.com/vim/vim.git $HOME/git/vim
  pushd $HOME/git/vim
  LDFLAGS=-L$HOME/usr/local/lib ./configure --with-features=huge \
              --enable-multibyte \
              --enable-rubyinterp=yes \
              --enable-python3interp=yes \
              --with-python3-config-dir=$(python3-config --configdir) \
              --enable-perlinterp=yes \
              --enable-luainterp=yes \
              --enable-cscope \
              --prefix=/usr/local
  make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
  sudo make install
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  sudo update-alternatives --set vi /usr/local/bin/vim
  popd
elif [[ $CLOUD_SHELL = "true" ]]; then
  git clone https://github.com/vim/vim.git $HOME/git/vim
  pushd $HOME/git/vim
  ./configure --with-features=huge \
              --enable-multibyte \
              --enable-rubyinterp=yes \
              --enable-python3interp=yes \
              --with-python3-config-dir=$(python3-config --configdir) \
              --enable-perlinterp=yes \
              --enable-luainterp=yes \
              --enable-cscope \
              --prefix=$HOME/local/vim \
              CPPFLAGS="-I$HOME/usr/local/include" \
              LDFLAGS="-L$HOME/usr/local/lib"
  make VIMRUNTIMEDIR=$HOME/local/vim/share/vim/vim82
  make install
  ln -s $HOME/local/vim/bin/vim $HOME/bin/vim
  popd
fi
if [ $DEBUG_MODE = "true" ]; then
  vim --version
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# GIT
###############################################################################
git config --global core.editor "vim"
# #  For using sessions in vim, particularly with Obsession plugin
git config --global core.excludesfile ~/.gitignore_global
touch ~/.gitignore_global
echo "Session.vim" >> ~/.gitignore_global
if [ $DOTFILES_CONTRIBUTOR = "true" ]; then
  if [ ! -z "$GIT_USERNAME" ]; then
    git config --global user.name $GIT_USERNAME
  fi
  if [ ! -z $GIT_EMAIL ]; then
    git config --global user.email $GIT_EMAIL
  fi
fi
if [ $DEBUG_MODE = "true" ]; then
  echo $DOTFILES_CONTRIBUTOR
  echo "$GIT_USERNAME"
  echo $GIT_EMAIL
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# KEY SETUP
###############################################################################
mkdir $HOME/.ssh
eval cp ${SSH_KEY_LOCATION} $HOME/.ssh/id_rsa
ssh-keygen -y -f $HOME/.ssh/id_rsa > $HOME/.ssh/id_rsa.pub
echo -en "Host github.com\n\tStrictHostKeyChecking no\n" >> $HOME/.ssh/config
echo -en "Host gitlab.com\n\tStrictHostKeyChecking no\n" >> $HOME/.ssh/config
echo -en "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> $HOME/.ssh/config
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/*
if [ $DEBUG_MODE = "true" ]; then
  ls -l $HOME/.ssh/
  read -n 1 -s -r -p "Press any key to continue"
fi

if [ $STARTING_IN_CLONE = "false" ]; then
    git clone https://github.com/rickfeldschau/dotfiles.git $HOME/git/dotfiles
    cd $HOME/git/dotfiles
fi
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# NODE
###############################################################################
# #  needed for YouCompleteMe vim plugin
wget -O- \
  https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh \
  | bash
if [ ! -z $XDG_CONFIG_HOME ]; then
  export NVM_DIR="$XDG_CONFIG_HOME/.nvm"
else 
  export NVM_DIR="$HOME/.nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
nvm install node
if [ $DEBUG_MODE = "true" ]; then
  node --version
  npm --version
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# CTAGS
###############################################################################
# #  after installation, go to source directory and run `ctags -R .`
if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  sudo apt install exuberant-ctags
else
  wget -O $HOME/ctags.tar.gz \
    http://prdownloads.sourceforge.net/ctags/ctags-${CTAGS_VERSION}.tar.gz
  tar -xf $HOME/ctags.tar.gz -C $HOME/git/
  pushd $HOME/git/ctags*
  ./configure --prefix=$HOME/local/ctags
  make 
  make install
  ln -s $HOME/local/ctags/bin/ctags $HOME/bin/ctags
  popd
fi
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi



###############################################################################
# FONTS 
###############################################################################
if [ $INSTALL_FONTS = "true" ]; then
  if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
    mkdir $HOME/.fonts
    cp $HOME/git/dotfiles/*.ttf $HOME/.fonts/
    sudo apt -y install fontconfig
    sudo fc-cache -f
  fi
fi
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi



###############################################################################
# ZSH
###############################################################################
if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  sudo apt -y install zsh
  sudo usermod --shell $(which zsh) $(whoami | awk '{print $1}')
else
  wget -O $HOME/zsh.tar.xz \
    https://sourceforge.net/projects/zsh/files/latest/download
  tar -xf $HOME/zsh.tar.xz -C $HOME/git/
  pushd $HOME/git/zsh*
  ./configure \
    --prefix=$HOME/local/zsh \
    CPPFLAGS="-I$HOME/usr/local/include" \
    LDFLAGS="-L$HOME/usr/local/lib"
  make -j2 
  make install
  popd
  ln -s $HOME/local/zsh/bin/zsh $HOME/bin/zsh
  # export PATH=$HOME/local/zsh/bin:$PATH
  # echo 'PATH=$HOME/local/zsh/bin:$PATH' >> $HOME/$SHELL_CONFIG_FILE
  # cp $HOME/git/dotfiles/zshenv $HOME/.zshenv
fi
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# ZSHRC 
###############################################################################
# #  Backup existing zshrc file
touch $HOME/.zshrc
cp $HOME/.zshrc{,.bak}
# #  Create a new zshrc file with color config at the top
echo 'export TERM="xterm-256color"' > $HOME/.zshrc
# #  Put old zshrc file back in place
cat $HOME/.zshrc.bak >> $HOME/.zshrc
# #  Copy over the custom zshrc file
cat zshrc >> $HOME/.zshrc
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# POWERLEVEL10K THEME 
###############################################################################
# #  For recommended fonts (already included in this dotfiles repo)
# #  https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  $HOME/.zsh/powerlevel10k
echo 'source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme' >> $HOME/.zshrc
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# VUNDLE (VIM PLUGIN MANAGER) AND VIM CONFIGURATION
###############################################################################
# TODO: use junegunn/vim-plug instead of Vundle
git clone https://github.com/VundleVim/Vundle.vim.git \
    $HOME/.vim/bundle/Vundle.vim
cat vimrc > $HOME/.vimrc
vim +PluginInstall +qall
sed -i '/colorscheme solarized/s/^"//' $HOME/.vimrc
sed -i "/let g:airline_theme='solarized'/s/^\"//" $HOME/.vimrc
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# ADDITIONAL VIM PLUGIN CONFIGURATION
###############################################################################
# YouCompleteMe
# #  Temporarly fix for this issue: https://github.com/ycm-core/YouCompleteMe/issues/3793#issuecomment-722977418
# pushd  ~/.vim/bundle/YouCompleteMe/third_party/ycmd
# git pull --rebase origin master
# git submodule update --init --recursive
# popd
pushd $HOME/.vim/bundle/YouCompleteMe
python3 install.py --all
# #  Add additonal completers as found here: 
# #   https://github.com/ycm-core/YouCompleteMe#explanation-for-the-quick-start-1
popd
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# ZSH PLUGINS 
###############################################################################
# ZSH autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  $HOME/.zsh/zsh-autosuggestions
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' \
    >> $HOME/.zshrc
# ZSH Z
git clone https://github.com/agkozak/zsh-z.git $HOME/.zsh/z
echo 'source ~/.zsh/z/zsh-z.plugin.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
# ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  $HOME/.zsh/zsh-syntax-highlighting
echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  >> $HOME/.zshrc
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# FZF 
###############################################################################
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --all
if [ $DEBUG_MODE = "true" ]; then
  read -n 1 -s -r -p "Press any key to continue"
fi


###############################################################################
# FINAL ZSH CONFIGURATION AND LOAD
###############################################################################
if [[ $CLOUD_SHELL = "true" ]]; then
  echo 'unsetopt BG_NICE' >> $HOME/.zshrc
fi

if [[ ( $(groups | grep "\<sudo\>") ) && ( $CLOUD_SHELL != "true" ) ]]; then
  zsh
else
  # echo 'PATH=$HOME/local/ctags/bin:$PATH' >> $HOME/.zshrc
  # echo 'PATH=$HOME/local/zsh/bin:$PATH' >> $HOME/.zshrc
  cat profile >> $HOME/.profile
  echo 'Entering final zsh configuration.'
  export SHELL=$(which zsh)
  "$SHELL"
fi

