# docker-gen
mkdir -p /tmp/templates && cd /tmp/templates
curl -o nginx.tmpl https://raw.githubusercontent.com/jwilder/docker-gen/master/templates/nginx.tmpl
docker run -d --name nginx-gen -v /var/run/docker.sock:/tmp/docker.sock:ro -v /home/www/nginx_config:/etc/nginx/conf.d -v /tmp/templates:/etc/docker-gen/templates -t jwilder/docker-gen  -notify 'service nginx reload' -watch -only-exposed /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default