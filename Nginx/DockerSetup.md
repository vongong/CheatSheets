**Consider docker instead of local install**
```sh
docker pull nginx
docker run -it -rm -d -p 8000:80 --name website nginx
```
[Docker Hub Nginx](https://hub.docker.com/_/nginx)

**docker compose for volumes**
```yaml
services:
  nginx:
    images: nginx:latest
    # build:
    #   context: .
    ports:
      - 8000:80
    volumes:
      - ./myhtml/:/usr/share/nginx/html/
```

**dockerfile**
```yaml
FROM nginx:latest
```