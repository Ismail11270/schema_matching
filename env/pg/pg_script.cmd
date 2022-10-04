SET variable=%1
set PGPASSWORD=postgres

echo DROP database if exists db%variable%;CREATE DATABASE db%variable%;GRANT ALL PRIVILEGES ON DATABASE db%variable% TO docker; | psql -U postgres --host=192.168.225.128 --port=5432
psql -U postgres -d db%variable% --host=192.168.225.128 --port=5432 < db_scripts/db%variable%.sql

