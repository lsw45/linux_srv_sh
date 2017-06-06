wget https://github.com/liexusong/php-beast/archive/master.zip
apt-get install unzip
unzip master.zip
cd php-beast-master
apt-get install php5-dev
phpize5
./configure
make
make install
touch /etc/php5/fpm/conf.d/beast.ini
echo 'extension=beast.so' >> /etc/php5/fpm/conf.d/beast.ini
service php5-fpm restart
touch /etc/php5/cli/conf.d/beast.ini
echo 'extension=beast.so' >> /etc/php5/cli/conf.d/beast.ini
