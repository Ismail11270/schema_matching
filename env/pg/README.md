To apply changes in the environment configuration use 

docker-compose up --force-recreate --build --renew-anon-volumes

docker ps - to get the list of containers

# Enter docker bash
sudo docker exec -it 3da566c2d00a bash

create database dump
pg_dump -U postgres db0 > db0.sql

#copy file from docker to host
docker cp db1:/data/dbtest.sql ./db0.sql
 
