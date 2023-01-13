## image naming in docker repo
registryDomain/imageName:tag
if registryDomain is skipped, use docker hub (docker.io/library)


## Pull from docker hub
if no tag, pull latest
```sh
docker pull redis 
docker pull redis:latest 
docker pull redis:4.0 
```

## what images on local
docker images

## create container
- -d = detached/deamon
- -rm = clean up
- -it = interactive processes
- -pxxx:yyy = bind port xxx=host yyy=container
- -e = env var
- -v = volume (3 types)
-   host: /home/mount/data:/var/mysql/data
-   anonymous: /var/mysql/data
-   named: name:/var/mysql/data
- --net = docker network
- --name = name container
```sh
docker run -d redis:latest
docker run -d --name dreamy redis:latest
docker run -d -p6000:6379 redis:latest
docker run -e username=admin redis:latest
docker run -v /home/mount/data:/var/mysql/data redis:latest
docker run -rm -it ubuntu /bin/bash
```

## shows what containers running
- -a = all containers
`docker ps`

## stop running containers
`docker stop [container-Id]`

## start stopped containers
`docker start [container-Id]`

## see the logs
- -f = stream logs
```sh
docker logs [container-Id]
docker logs [name]
docker logs [container-Id] | tail
```

## run command aka shell
- -it = interactive terminal
```
docker exec -it /bin/bash [container-Id] 
docker exec -it /bin/sh [container-Id] 
```

## docker network
- ls = list
- create = create
```
docker network ls
docker network create mongo-network
```

## build
- .= location of Dockerfile
`docker build -t my-app:1.0 .`

## remove container (must do before image)
`docker rm [Container Id]`

## remove image
`docker rmi [Image Id]`

## tag
```
docker tag my-app:latest docker-id/my-app:latest
docker tag my-app:latest private-repo.com/my-app:latest
docker tag 0e5574283393 myapp:version1.0
```

## push image
- must login = docker login
- must tag before push
```
docker push docker-id/my-app:latest
docker push private-repo.com/my-app:latest
```

## docker volumes
- windows: c:\ProgramData\docker\volumes
- linux: /var/lib/docker/volumes
- macos: /var/lib/docker/volumes
  - actually creates linux vm to store docker data

# start docker compose file all at same time
docker-compose -f mongo.yml up
docker-compose -f mongo.yml up -d

# stop docker containers in compose file
docker-compose -f mongo.yml down

# other docker compose
docker-compose -f mongo.yml start
docker-compose -f mongo.yml stop
docker-compose -f mongo.yml ps