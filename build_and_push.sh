./mvnw -DDATASOURCE_HOST=192.168.137.215 clean package
docker build . -t devlifestartup/cats-api:1.0.0
docker push devlifestartup/cats-api:1.0.0