# Assumes that, if no root access, you already ran: 
#  ./configure --prefix=$HOME/local/zsh && make -j2 && make install
export SHELL=$(which zsh)
"$SHELL"
