#! /bin/bash

PYTHON_CONFIG_DIR=($(dirname `find /usr/lib* -path "/usr/lib*/python2*config*/*" -a -name "python.o"`))

echo $PYTHON_CONFIG_DIR

if [[ -n "$1" ]]; then
    tar jxvf $1
else
    command -v hg
    if [[ $? -eq 0 ]]; then
        hg clone -r $(cat ../vim_revision) https://vim.googlecode.com/hg/ vim
    else
        echo "Where is your source code pack"
        exit 1
    fi
fi


pushd vim

./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=${PYTHON_CONFIG_DIR[0]} --enable-perlinterp --enable-cscope --prefix=$HOME/.local/vim
make
make install

popd
rm -rf vim
