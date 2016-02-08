#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# setup installs
apt-get update
apt-get upgrade -qqy

apt-get install -qqy build-essential unzip git cmake flex autoconf
apt-get install -qqy python-dev python-setuptools
apt-get install -y apache2 apache2-utils apache2-dev apache2-dbg libfcgi-dev libapache2-mod-auth-pgsql libapache2-mod-fastcgi
# use one or the other but not both.
apt-get install -qqy libapache2-mod-python
#apt-get install -qqy libapache2-mod-wsgi
apt-get install -qqy libfreetype6-dev libxml2-dev libxslt1-dev libtiff-dev libtiff5-dev libpng12-dev libpng-dev libjpeg8-dev
apt-get install -qqy libblas-dev liblapack-dev gfortran libffi-dev libssl-dev

#pip installs
apt-get install -qqy python-pip
pip install pip --upgrade
pip install urllib3[secure]
pip install numpy -q --upgrade

#install postgresql postgis and gdal
apt-get install -qqy libgdal-dev gdal-bin python-gdal
apt-get install -qqy postgresql-9.4 postgresql-contrib postgresql-9.4-pgrouting postgresql-9.4-postgis-2.1 postgis python-psycopg2 binutils libproj-dev libpq-dev

#workon pygeoan_cb
pip install pyproj -q
#pip install shapely
#pip install matplotlib
#pip install descartes
#pip install pyshp
pip install geojson
#pip install pandas
#pip install scipy
#pip install networkx
#pip install pysal
pip install ipython
#pip install django==1.8
pip install owslib
#pip install folium
#pip install jinja2
#pip install djangorestframework==3.1.3

PG_VERSION=9.4
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"
sed -i  's/md5/trust/' "$PG_HBA"
sed -i  's/peer/trust/' "$PG_HBA"

service postgresql restart

