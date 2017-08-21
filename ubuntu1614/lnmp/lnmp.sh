# this is for ubuntu1604 auto init
# jry 598821125@qq.com 2017-06-06

# root
# sed -i -e "s/PermitRootLogin\swithout-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Requirements
apt-get update
apt-get -y install vim wget curl zip unzip git git-core mailutils nginx php php-fpm php-curl php-gd php-mysql php-bcmath php-dev mysql-server


# nginx config
sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf

# 为nginx添加一个在/home/ly/nginx_config站点配置文件目录便于管理
mkdir -p /home/ly/nginx_config;
sed -i '/include\s\/etc\/nginx\/sites-enabled\/\*;/a    include /home/ly/nginx_config/*;' /etc/nginx/nginx.conf
mkdir -p /home/ly/www;

# 拷贝默认站点配置文件至/home/ly/nginx_config
rm /etc/nginx/sites-enabled/default
cp ./mysite.conf  /home/ly/nginx_config

# 日志
mkdir /home/ly/log;
mkdir /home/ly/log/nginx;
touch /home/ly/log/nginx/access.log;
touch /home/ly/log/nginx/error.log;

# 权限
chown -R www-data:www-data /home/ly/log/
chown -R www-data:www-data /home/ly/www/

# php-fpm config
#sudo sed -i -e "s/;cgi.fix_pathinfo=0/cgi.fix_pathinfo=1/g" /etc/php5/fpm/php.ini

# 上传大小限制改为100M
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php/7.0/fpm/php.ini
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php/7.0/fpm/php.ini

# 后台守护进程模式
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf


# mysql config

# 开启mysql远程访问
sed -i -e"s%^bind-address\s*=\s*127.0.0.1%bind-address = 0.0.0.0%" /etc/mysql/my.cnf

# 移动mysql数据目录到/home/mysql_data下便于数据集中管理
sed -i -e"s%^datadir\s*=\s*/var/lib/mysql%datadir = /home/ly/mysql_data%" /etc/mysql/my.cnf
sed -i -e"s%^\s\s/var/lib/mysql%  /home/ly/mysql_data%" /etc/apparmor.d/usr.sbin.mysqld
cp -r /var/lib/mysql /home/ly/mysql_data

# 权限很重要不然mysql无法启动
chown -R mysql:mysql /home/ly/mysql_data

# restart
service apparmor restart
service nginx restart
service php7.0-fpm restart
service mysql restart


# 禁止别人ping服务器
sed -i '$a\net.ipv4.icmp_echo_ignore_all = 1' /etc/sysctl.conf
sysctl -p
