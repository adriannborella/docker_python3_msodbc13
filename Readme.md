Se creo una imagen basada en ubuntu 16.04, con el conector a sql version 13, para poder conectarse a sql con versiones antiguas

Tambien se instalo python en la version 3.9

Se relaciono la carpeta script con la carpeta /home/app

Para correrlo

docker-compose up -d

correr script de python

docker-compose exec python python3 <nombre del script>.py