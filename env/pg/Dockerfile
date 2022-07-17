FROM library/postgres

RUN apt-get update
RUN apt-get -y install unzip dos2unix

RUN mkdir /data
RUN mkdir /data/db_scripts
ADD  db_scripts /data/db_scripts

COPY install.sh /docker-entrypoint-initdb.d/
RUN dos2unix /docker-entrypoint-initdb.d/*.sh
