./mvnw "-DDATASOURCE_HOST=db.bromen.fun -DDATASOURCE_PORT=5432" clean package
docker build . -t devlifestartup/cats-api:1.0.0
docker push devlifestartup/cats-api:1.0.0