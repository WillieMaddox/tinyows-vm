#!/usr/bin/env bash

# Now the instructions from http://mapserver.org/tinyows/openlayershowto.html
# Setup the database
createdb -U postgres tinyows
psql -U postgres -d tinyows < `pg_config --sharedir`/contrib/postgis-2.1/postgis.sql
psql -U postgres -d tinyows < `pg_config --sharedir`/contrib/postgis-2.1/spatial_ref_sys.sql
psql -U postgres -d tinyows < `pg_config --sharedir`/contrib/postgis-2.1/topology.sql
psql -U postgres -d tinyows < `pg_config --sharedir`/contrib/postgis-2.1/rtpostgis.sql

# Download some sample data and populate the database with it.
wget ftp://ftp.intevation.de/freegis/frida/frida-1.0.1-shp.tar.gz
tar xvzf frida-1.0.1-shp.tar.gz
cd frida-1.0.1-shp
shp2pgsql -g geom -s 31467 -W LATIN1 -I gruenflaechen.shp frida | psql -U postgres -d tinyows
service postgresql restart

cp /vagrant/config.xml /etc/tinyows.xml
# mkdir /usr/local/tinyows
# cp /vagrant/config.xml /usr/local/tinyows/config.xml

/usr/lib/cgi-bin/tinyows --check

sed -i "s/\/var\/www\/html/\/var\/www/" /etc/apache2/sites-available/000-default.conf
echo "ServerName localhost" > /etc/apache2/conf-available/local-servername.conf
a2enconf local-servername
service apache2 reload
service apache2 restart

/usr/lib/cgi-bin/tinyows --check

wget "http://localhost/cgi-bin/tinyows" --post-data=/etc/tinyows.xml --header="Content-Type: application/xml; charset=UTF-8" -O /tmp/ttt.txt 

# Install and configure Openlayers2
git clone https://github.com/openlayers/ol2.git
cd ol2
git checkout release-2.12
cd ..
mkdir /var/www/OpenLayers-2.12
cp -r ol2/* /var/www/OpenLayers-2.12/
cp ol2/examples/proxy.cgi /usr/lib/cgi-bin/
ln -s /usr/lib/cgi-bin/proxy.cgi /usr/lib/cgi-bin/proxy.fcgi
#wget http://openlayers.org/download/OpenLayers-2.12.tar.gz
#tar xvzf OpenLayers-2.12.tar.gz
#mv OpenLayers-2.12 /YOUR/SERVER/HTDOCS/
sed -i "s/'www.openlayers.org'/'localhost', '0.0.0.0', '127.0.0.1', 'www.openlayers.org'/" /usr/lib/cgi-bin/proxy.cgi

cp /vagrant/tinyows.html /var/www/OpenLayers-2.12/examples/tinyows.html
cp /vagrant/tinyows.js /var/www/OpenLayers-2.12/examples/tinyows.js

wget "http://localhost/cgi-bin/proxy.cgi" --post-data=/etc/tinyows.xml --header="Content-Type: application/xml; charset=UTF-8" -O /tmp/ttt.txt 

