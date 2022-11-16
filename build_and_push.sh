./mvnw "-DDATASOURCE_HOST=db.bromen.fun -DDATASOURCE_PORT=5432 -DSERVICE_NAME=cats -DSERVICE_PORT=8088" clean package
docker build . -t devlifestartup/cats-api:1.0.0.36
docker push devlifestartup/cats-api:1.0.0.36