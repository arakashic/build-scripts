#! /bin/bash

if [[ -x /usr/bin/yum ]]; then
    sudo yum -y groupinstall "Development Tools" "Development Libraries"
    sudo yum -y install perl-devel python-devel ruby-devel ruby perl-ExtUtils-Embed ncurses-devel
    sudo yum -y install mercurial
fi

if [[ -x /usr/bin/apt-get ]]; then
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev \
        libxpm-dev libxt-dev python-dev ruby-dev mercurial
    sudo apt-get remove vim vim-runtime gvim
fi

PYTHON_CONFIG_DIR=($(dirname `find /usr/lib* -path "/usr/lib*/python2*config*/*" -a -name "python.o"`))

echo $PYTHON_CONFIG_DIR

# vim 7.4
# hg clone -r 359743c1f59a https://vim.googlecode.com/hg/ vim
# vim 7.4-330
# hg clone -r f9fa2e506b9f https://vim.googlecode.com/hg/ vim
# vim 7.4-488
hg clone -r 3ec6e0ef4a67 https://vim.googlecode.com/hg/ vim
cd vim

./configure --with-features=huge --enable-luainterp --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=${PYTHON_CONFIG_DIR[0]} --enable-perlinterp --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install

cd -
rm -rf vim
