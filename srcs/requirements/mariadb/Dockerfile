FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y
RUN apt install vim -y

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
#COPY /conf/50-server.cnf /etc/mysql/my.cnf
COPY tools/create_database.sh /scripts/create_database.sh

RUN touch /var/log/mysql/error.log /var/log/mysql/mysql.log
RUN chown mysql var/log/mysql -Rf
#RUN /scripts/create_database.sh
CMD ["bash", "/scripts/create_database.sh"]
