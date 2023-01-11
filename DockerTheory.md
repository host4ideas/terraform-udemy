# Docker notes

## Containers

- `docker ps -a` -> List containers
- `docker start **container name or id**` -> start container
- `docker rm **Container ID or name**` -> Remove container
- `docker run -d ubuntu bash -c **commands**` -> Run container and invoke bash
- `docker exec **Container ID** **Command**` -> Run command on container's terminal
- `docker run -it **image**` -> Start new container with to serve a command
- `docker logs **Container ID**` -> Show logs of a container

### Dev environment

- Bash:

```console
docker run -dp 3000:3000 \
    -w /app -v "$(pwd):/app" \
    node:18-alpine \
    sh -c "yarn install && yarn run dev"
```

- PowerShell:

```console
docker run -dp 3000:3000 `
    -w /app -v "$(pwd):/app" `
    node:18-alpine `
    sh -c "yarn install && yarn run dev"
```

## Images

- `docker run -d -p 80:80 docker/getting-started` -> Start a new container from a image
- `docker tag getting-started **New image name**` -> Change image's name

## Volumes

- `docker volume create **volume name**` -> Create volume of type volumename
- `docker run -dp **ports** -v **volume name**:**volume mount route** **image name or ID**` -> Start new container with a volume mounted in a route

|               |Named volumes|  Bind Mounts  |
|:-------------:|:-----------:|:--------------:|
| Host Location |Docker chooses               |You control|
|Mount Example (using -v)|my-volume:/usr/local/data|/path/to/data:/usr/local/data|
|Populates new volume with container contents|       Yes      |        No     |
|            Supports Volume Drivers         |       Yes      |        No     |

## Docker Hub

- `docker login -u ***Username**` -> Login
- `docker push **Image name or ID**:**tag**` -> Push new image

## Dockerfile

- `docker build -t **Image name** **Dockerfile path**` -> Build form Dockerfile

- Eg.:

```console
FROM node:18-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
```

## Network

### Create a nework and attach the MySQL container at startup

`docker network create **network name**` -> Create network
`docker run -it --network todo-app nicolaka/netshoot` -> Image for network troubleshooting
`dig mysql` -> Debug mysql

#### Create MySQL Docker container

- ```console
    docker run -d \
    --network todo-app --network-alias mysql \
    -v todo-mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=todos \
    mysql:8.0
    ```

- ```console
    docker run -d `
    --network todo-app --network-alias mysql `
    -v todo-mysql-data:/var/lib/mysql `
    -e MYSQL_ROOT_PASSWORD=secret `
    -e MYSQL_DATABASE=todos `
    mysql:8.0
    ```

> This will create a volume named: todo-mysql-data

#### Confirm database is running

1. Execute mysql -p command
`docker exec -it **mysql-container-id** mysql -p`
2. Pass
`secret`
3. Check databases
`SHOW DATABASES;`

#### Run app container

- ```console
    docker run -dp 3000:3000 \
    -w /app -v "$(pwd):/app" \
    --network todo-app \
    -e MYSQL_HOST=mysql \
    -e MYSQL_USER=root \
    -e MYSQL_PASSWORD=secret \
    -e MYSQL_DB=todos \
    node:18-alpine \
    sh -c "yarn install && yarn run dev"
    ```

- ```console
    docker run -dp 3000:3000 `
    -w /app -v "$(pwd):/app" `
    --network todo-app `
    -e MYSQL_HOST=mysql `
    -e MYSQL_USER=root `
    -e MYSQL_PASSWORD=secret `
    -e MYSQL_DB=todos `
    node:18-alpine `
    sh -c "yarn install && yarn run dev"
    ```

## Docker Compose

- `docker compose up -d` -> Start services in background
- `docker compose down --volumes` -> Stop services and delete volumes
- `docker compose logs -f **service name**`

Previous app example:

```console
services:
  app:
    image: node:18-alpine
    command: sh -c "yarn install && yarn run dev"
    ports:
      - 3000:3000
    working_dir: /app
    volumes:
      - ./:/app
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASSWORD: secret
      MYSQL_DB: todos

  mysql:
    image: mysql:8.0
    volumes:
      - todo-mysql-data:/var/lib/mysql
    environment: 
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: todos

volumes:
  todo-mysql-data:
```

## Misc

- `docker scan getting-started` -> Scan vulnerabilities
- `docker image history getting-started` -> History of an image
- `docker image history --no-trunc getting-started` -> Full history of an image
