### Development

#### Create Docker image 
`docker build -t dockerized-server:dev -f Dockerfile.dev .`

#### Run Docker container
UNIX:
```bash
docker run -it --rm -v ${PWD}:/app -v /app/node_modules -p 3001:3000 -e CHOKIDAR_USEPOLLING=true dockerized-server:dev
```

WINDOWS:
```bash
docker run -it --rm -v %cd%:/app -v /app/node_modules -p 3001:3000 -e CHOKIDAR_USEPOLLING=true dockerized-server:dev
```

---
