# this is for ubuntu auto init
# jry 598821125@qq.com 2016-08-08

# Requirements
service nginx stop
service php5-fpm stop
apt-get -y install apache2 libapache2-mod-php5

# 为nginx添加一个在/home/ly/nginx_config站点配置文件目录便于管理
mkdir -p /home/ly/apache2_config;
sed -i '/IncludeOptional\ssites-enabled\/\*\.conf/a    IncludeOptional /home/ly/apache2_config/*' /etc/apache2/apache2.conf
cp /etc/apache2/sites-enabled/000-default.conf  /home/ly/apache2_config/default.conf;
rm /etc/apache2/sites-enabled/000-default.conf;

# 日志
mkdir /home/ly/log;
mkdir /home/ly/log/apache2;
touch /home/ly/log/apache2/access.log;
touch /home/ly/log/apache2/error.log;

# 开启URL重写模块
ln -s /etc/apache2/mods-available/rewrite.load  /etc/apache2/mods-enabled/

# 修改默认目录
sed -i -e"s%/var/www/%  /home/ly/www/%" /etc/apache2/apache2.conf

# 上传大小限制改为100M
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/apache2/php.ini
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/apache2/php.ini

# 权限
chown -R www-data:www-data /home/ly/log/
chown -R www-data:www-data /home/ly/www/

service apache2 restart
