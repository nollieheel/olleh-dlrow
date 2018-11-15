# Rails

A Dockerized hello world rails app.

## Docker

```
$ docker build -t hello .
$ docker run -e MESSAGE=whatever -d -p 8080:3000 hello
```

Runs the app (Puma) by default. To run Sidekiq, instead:

```
$ docker run -e REDIS_URL=redis://some.where:6379 -d hello /bin/bash docker/start.sh sidekiq
```

Note: Sidekiq requires Redis, which is not included in the Docker image.
