#!/bin/bash

export PGUSER=postgres
psql <<- SHELL
  CREATE USER docker;
  CREATE DATABASE "db0";
  GRANT ALL PRIVILEGES ON DATABASE "db0" TO docker;
  CREATE DATABASE "db1";
  GRANT ALL PRIVILEGES ON DATABASE "db1" TO docker;
  CREATE DATABASE "db2";
  GRANT ALL PRIVILEGES ON DATABASE "db2" TO docker;
  CREATE DATABASE "db3";
  GRANT ALL PRIVILEGES ON DATABASE "db3" TO docker;
  CREATE DATABASE "db4";
  GRANT ALL PRIVILEGES ON DATABASE "db4" TO docker;
  CREATE DATABASE "db5";
  GRANT ALL PRIVILEGES ON DATABASE "db5" TO docker;
  CREATE DATABASE "db6";
  GRANT ALL PRIVILEGES ON DATABASE "db6" TO docker;
  CREATE DATABASE "db7";
  GRANT ALL PRIVILEGES ON DATABASE "db7" TO docker;
  CREATE DATABASE "db8";
  GRANT ALL PRIVILEGES ON DATABASE "db8" TO docker;
  CREATE DATABASE "db9";
  GRANT ALL PRIVILEGES ON DATABASE "db9" TO docker;
SHELL

cd /data/db_scripts
for s in *.sql; do
	psql -d db$((counter++)) < $s
done
