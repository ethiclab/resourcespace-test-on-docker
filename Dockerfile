FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y -q apache2 php7.0 php7.0-dev php7.0-gd php7.0-mysql php-mbstring php-zip libapache2-mod-php php7.0-mysql mysql-server
RUN apt-get install -y imagemagick ghostscript antiword xpdf libav-tools libimage-exiftool-perl cron wget
VOLUME ["/var/lib/mysql", "/tmp/resourcespace"]
WORKDIR /tmp/resourcespace/tests
ADD config.php /tmp/config.php
ADD php.ini /tmp/php.ini
ADD command /tmp/command
ADD ini.sql /tmp/ini.sql
ADD query.sql /tmp/query.sql
RUN mkdir /var/run/mysqld
RUN touch /var/run/mysqld/mysqld.sock
RUN chown -R mysql /var/run/mysqld
CMD ["/bin/bash", "/tmp/command"]
