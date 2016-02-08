#!/usr/bin/env bash

git clone https://github.com/WillieMaddox/tinyows.git
#git clone git://github.com/mapserver/tinyows.git
cd tinyows
autoconf
./configure
make
make install
#make install-demo
cp tinyows /usr/lib/cgi-bin/
#ln -s /usr/lib/cgi-bin/tinyows /usr/lib/cgi-bin/tinyows.fcgi
cd

