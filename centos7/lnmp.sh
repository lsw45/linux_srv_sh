yum install -y vim wget zip unzip  git httpd php php-mysql php-odbc php-ldap php-gd php-mbstring php-xml php-xml-rpc php-bcmath libjpeg* mariadb ;
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm;
yum install -y nginx;
service nginx start
systemctl enable nginx.service
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload