FROM ubuntu:16.04
MAINTAINER jecyhw "1147352923@qq.com"
RUN apt update
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt update

#install php5.6 and mongo extention
RUN apt install -y php5.6 php5.6-mongo php5.6-fpm nginx git vim supervisor

RUN git clone https://github.com/iwind/rockmongo.git /var/www/html/rockmongo
ADD rockmongo/config.php /var/www/html/rockmongo/config.php

ADD nginx/rockmongo.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/
EXPOSE 80

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

# docker run -i -t -p 80
