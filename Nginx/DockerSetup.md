**Consider docker instead of local install**
- youtube Very Academy - Nginx Mastery
- [nginx mastery code repo](https://github.com/veryacademy/yt-nginx-mastery-series)
- [Docker Hub Nginx](https://hub.docker.com/_/nginx)

**docker cmds**
```sh
docker pull nginx
docker run -it -rm -d -p 8000:80 --name website nginx
```

**docker compose for volumes**
```yaml
services:
  nginx:
    # images: nginx:latest
    build:
      context: .
    ports:
      - 8000:80
    volumes:
      - ./myhtml/:/usr/share/nginx/html/
```

**dockerfile**
```yaml
FROM nginx:latest
RUN apt-get update && apt-get install -y procps
```