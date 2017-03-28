cd /usr/local/sbin
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
./certbot-auto
certbot-auto certonly --webroot -w /home/www/lingyun -d lingyun.net -d www.lingyun.net -d git.lingyun.net -d doc.lingyun.net -d bbs.lingyun.net -d u.lingyun.net -d oa.lingyun.net -d zb.lingyun.net -d zp.lingyun.net -d v.lingyun.net -d lyshop.lingyun.net

# 90天会过期用下面的语句更新时间
cd /usr/local/sbin
./certbot-auto renew --force-renew
