# install docker

apt-get update
apt-get -y install apt-transport-https ca-certificates
apt-key -y adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
touch /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install -y docker-engine
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://09cbc264.m.daocloud.io
mv /var/lib/docker /home/docker_data
ln -s  /home/docker_data  /var/lib/docker
service docker start
docker run hello-world
