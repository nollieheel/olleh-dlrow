# Rails

A Dockerized hello world rails app.

## Docker

```
$ docker build -t hello .
$ docker run -e MESSAGE=whatever -d -p 8080:3000 hello
```

Runs the app (Puma) only, by default. To run Sidekiq as well:

```
$ docker run -e MESSAGE=whatever -e REDIS_URL=redis://some.where:6379 -d -p 8080:3000 hello /bin/bash docker/start.sh sidekiq
```

Note: Sidekiq requires Redis, which is not included in the Docker image.
