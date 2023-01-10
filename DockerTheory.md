# Docker notes

## Containers

- `docker ps -a` -> List containers
- `docker start **container name or id**` -> start container
- `docker rm **Container ID or name**` -> Remove container
- `docker run -d ubuntu bash -c **commands**` -> Run container and invoke bash
- `docker exec **Container ID** **Command**` -> Run command on container's terminal
- `docker run -it **image**` -> Start new container with to serve a command

## Images

- `docker run -d -p 80:80 docker/getting-started` -> Start a new container from a image
- `docker build -t **Image name** **Dockerfile path**`
- `docker tag getting-started **New image name**` -> Change image's name

## Volumes

- `docker volume create **volume name**` -> Create volume of type volumename
- `docker run -dp **ports** -v **volume name**:**volume mount route** **image name or ID**` -> Start new container with a volume mounted in a route

## Docker Hub

- `docker login -u ***Username**` -> Login
- `docker push **Image name or ID**:**tag**` -> Push new image
