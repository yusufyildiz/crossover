#!/bin/bash

set -e -x

# Needed so that the aptitude/apt-get operations will not be interactive
export DEBIAN_FRONTEND=noninteractive

add-apt-repository ppa:formorer/icinga --yes
apt-get --yes --quiet update && apt-get -y --quiet upgrade && apt-get -y --quiet install mysql-client htop git awscli

wget -qO- https://get.docker.com/ | sh

# pull the docker images & run
docker pull mysql
docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=toor -d mysql:latest
docker pull tutum/apache-php
docker build -t tutum/apache-php .
docker run -d -p 80:80 --name apache --link mysql:mysql -v /var/www/html:/var/www/html tutum/apache-php:latest

git clone https://github.com/yusufyildiz/crossover.git && cd crossover 
cp db.php index.php logout.php /var/www/html/

mkdir /var/log/containers
cp logcron.sh /root && chmod +x /root/logcron.sh
echo '* 19 * * * /root/logcron.sh' | crontab -
