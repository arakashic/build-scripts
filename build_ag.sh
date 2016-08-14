#! /bin/bash

if [ -x /usr/bin/apt-get ]; then
    sudo apt-get install automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
fi
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
./build.sh
sudo make install
cd -
rm -rf the_silver_searcher
