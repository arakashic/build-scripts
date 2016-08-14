#! /bin/bash

PYTHON_CONFIG_DIR=($(dirname `find /usr/lib* -path "/usr/lib*/python2*config*/*" -a -name "python.o"`))

echo $PYTHON_CONFIG_DIR

# vim 7.4
# hg clone -r 359743c1f59a https://vim.googlecode.com/hg/ vim
# vim 7.4-330
# hg clone -r f9fa2e506b9f https://vim.googlecode.com/hg/ vim
# vim 7.4-488
# hg clone -r 3ec6e0ef4a67 https://vim.googlecode.com/hg/ vim
# vim 7.4-712
hg clone -r f2a751a9ee72 https://vim.googlecode.com/hg/ vim
cd vim

./configure --with-features=huge --enable-luainterp --with-lua-prefix=/usr/include/lua5.3 --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=${PYTHON_CONFIG_DIR[0]} --enable-perlinterp --enable-gui=gtk2 --enable-cscope --prefix=/usr | tee config.log
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install

cd -
rm -rf vim

/usr/bin/vim --version

# in case lua does not work
# sudo mkdir -p /usr/include/lua5.3/include
# sudo cp /usr/include/lua*.h* /usr/include/lua5.3
# sudo cp /usr/include/lua*.h* /usr/include/lua5.3/include
# sudo ln -s /usr/lib/liblua.so /usr/local/lib/liblua.so
