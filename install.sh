#!/bin/bash

rm -rf stlink-master/build/
cd stlink-master
make release
cd build/Release/
sudo make install
cp /usr/local/bin/st*  ~/workspace/stm32tools/
sudo ldconfig
