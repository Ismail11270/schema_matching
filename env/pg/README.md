To apply changes in the environment configuration use 

docker-compose up --force-recreate --build --renew-anon-volumes

docker ps - to get the list of containers

### Enter docker bash
sudo docker exec -it 3da566c2d00a bash

### create database dump
pg_dump --no-comments -s -U postgres db0 | sed -r '/^--/d' > /data/db0.sql

sudo docker inspect pg_db_1 | grep "IPAddress"

pg_dump -s --no-comments -U postgres --dbname=db0 --host=172.18.0.2 --port=5432 | sed -r '/^--/d' > dump.sql

### copy file from docker to host
docker cp db1:/data/dbtest.sql ./db0.sql

